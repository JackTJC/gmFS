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
    @EnvironmentObject var shareSrv:ShareService
    @Binding var sharedFile:SharedFileModel
    @State private var subNodes:[Node] = []
    @State private var selectedNode:Node?
    @State private var isEditMode:EditMode = .inactive
    @Binding var showingDirTree:Bool
    @Binding var saveSucc:Bool
    private let userCache = AppManager.getUserCache()
    
    /// 根据rootNodeID拉取文件夹
    private func fetchDir(){
        BackendService().GetNode(nodeID: rootNodeId){resp in
            var copyNodes  = resp.node.subNodeList.filter{node in
                return node.nodeType==NodeType.dir// 只需要文件夹
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
            }.background(NavigationLink("",destination: DirTreeView(rootNodeId: node.nodeID,sharedFile: self.$sharedFile,showingDirTree: self.$showingDirTree,saveSucc: self.$saveSucc)).opacity(0))
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
                    // 使用自己的主密钥加密收到的文件密钥，再调用接口注册文件
                    let encKey = try! EncryptService.symEncWithId(identity: userCache.name, plainText: self.sharedFile.key)
                    BackendService().RegisterFile(fileID: self.sharedFile.fileID, dirID: self.selectedNode!.nodeID,key: encKey){resp in
                        switch resp.baseResp.statusCode{
                        case StatusCode.success:
                            saveSucc=true
                            showingDirTree=false
                            let idx = self.shareSrv.recvFiles.firstIndex{shareFile in
                                return shareFile.fileID==self.sharedFile.fileID
                            }
                            self.shareSrv.recvFiles.remove(at: idx!)
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
    @State static var testSharedFile = SharedFileModel(fileID: 0, fileName: "",key: Data())
    @State static var testSaveSucc = false
    static var previews: some View {
        NavigationView{
            DirTreeView(rootNodeId: 1517026803300962304,sharedFile: $testSharedFile,showingDirTree: $testShowDir,saveSucc: $testSaveSucc)
                .environmentObject(ShareService())
        }
    }
}
