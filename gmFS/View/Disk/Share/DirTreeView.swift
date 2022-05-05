//
//  DirTreeView.swift
//  gmFS
//
//  Created by jincaitian on 2022/5/3.
//

import SwiftUI
import SimpleToast


struct DirTreeView: View {
    var rootNodeId:Int64
    @Binding var sharedFile:SharedFile
    @State private var subNodes:[Node] = []
    @State private var selectedNode:Node?
    @State private var isEditMode:EditMode = .inactive
    @Binding var showingDirTree:Bool
    @Binding var saveSucc:Bool
    private let userCache = AppManager.getUserCache()
    private func fetchDir(){
        BackendService().GetNode(nodeID: rootNodeId){resp in
            var copyNodes  = resp.subNodes.filter{node in // 只需要文件夹
                return node.nodeType==NodeType.dir
            }
            copyNodes.sort{ n1,n2 in // 字典序排序
                return n1.nodeName<n2.nodeName
            }
            subNodes=copyNodes
        }failure: { Error in
            
        }
    }
    
    var body: some View {
        List(subNodes,id:\.self,selection: self.$selectedNode){node in
            HStack{
                Image(systemName: "folder")
                Text(node.nodeName)
            }.background(NavigationLink("",destination: DirTreeView(rootNodeId: node.nodeID,sharedFile: self.$sharedFile,showingDirTree: self.$showingDirTree,saveSucc: self.$saveSucc)))
        }
        .onAppear{
            fetchDir()
        }
        .toolbar{
            Button(isEditMode.isEditing ? "Save": "Select") {
                switch isEditMode {
                case .active:
                    self.isEditMode = .inactive
                    if self.selectedNode == nil{
                        return
                    }
                    let encKey = try! EncryptService.aesEncrypt(identity: userCache.name, plainText: self.sharedFile.key)
                    BackendService().RegisterFile(fileID: self.sharedFile.fileID, dirID: self.selectedNode!.nodeID,key: encKey){resp in
                        switch resp.baseResp.statusCode{
                        case StatusCode.success:
                            saveSucc=true
                            showingDirTree=false
                        default:
                            break
                        }
                    }failure: { err in
                        
                    }
                case .inactive:
                    self.isEditMode = .active
                default:
                    break
                }
            }
        }
        .environment(\.editMode, $isEditMode)
    }
}

struct DirTreeView_Previews: PreviewProvider {
    @State static var testOp = Int64(0)
    @State static var testShowDir = false
    @State static var testSharedFile = SharedFile(fileID: 0, fileName: "",key: Data())
    @State static var testSaveSucc = false
    static var previews: some View {
        NavigationView{
            DirTreeView(rootNodeId: 1517026803300962304,sharedFile: $testSharedFile,showingDirTree: $testShowDir,saveSucc: $testSaveSucc)
        }
    }
}
