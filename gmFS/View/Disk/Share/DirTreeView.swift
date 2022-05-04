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
    @Binding var operateID:Int64
    @State private var subNodes:[Node] = []
    @State private var selectedNode:Node?
    @State private var isEditMode:EditMode = .inactive
    @State private var saveSuccess = false
    
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
            }.background(NavigationLink("",destination: DirTreeView(rootNodeId: node.nodeID,operateID: self.$operateID)))
        }
        .onAppear{
            fetchDir()
        }
        .toolbar{
            Button(isEditMode.isEditing ? "保存": "选择") {
                switch isEditMode {
                case .active:
                    self.isEditMode = .inactive
                    if self.selectedNode == nil{
                        return
                    }
                    BackendService().RegisterFile(fileID: operateID, dirID: self.selectedNode!.nodeID){resp in
                        switch resp.baseResp.statusCode{
                        case StatusCode.success:
                            saveSuccess=true
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
        .simpleToast(isPresented: self.$saveSuccess, options: Toast.succOrFailOpt){
            HStack{
                Image(systemName: "paperplane")
                Text("Save Success")
            }
            .padding()
            .background(Color.blue.opacity(0.8))
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }
        .environment(\.editMode, $isEditMode)
    }
}

struct DirTreeView_Previews: PreviewProvider {
    @State static var testOp = Int64(0)
    static var previews: some View {
        NavigationView{
            DirTreeView(rootNodeId: 1517026803300962304,operateID: $testOp)
        }
    }
}
