//
//  FileListView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/25.
//

import SwiftUI

struct FileListView: View {
    @State private var searchText = ""
    @State private var showingAlert = false
    @State private var alertText = ""
    @State private var showingMCBrowser  = false
    @State private var showingAddFile = false
    @State private var showingInputDirName = false
    @State private var directoryName = ""
    @State private var subNodes:[Node] = []
    var shareService = ShareService()
    var nodeID:Int64
    private func alertWith(_ text:String){
        showingAlert=true
        alertText=text
    }
    private func fetchNode(){
        BackendService().GetNode(nodeID: nodeID){resp in
            var copyNodes  = resp.subNodes
            copyNodes.sort{ n1,n2 in
                if n1.nodeType==n2.nodeType{
                    // 节点名字典序
                    return n1.nodeName<n2.nodeName
                }
                // 文件夹在上
                return n1.nodeType.rawValue>n2.nodeType.rawValue
            }
            subNodes=copyNodes
        }failure: { Error in
            
        }
    }
    var body: some View {
        List{
            ForEach(subNodes){node in
                NodeView(node: node)
            }
        }
        .onAppear{
            fetchNode()
        }
        .refreshable {
            fetchNode()
        }
    }
}

struct FileListView_Previews: PreviewProvider {
    static var previews: some View {
        FileListView(nodeID: 1517026803300962304)
        
    }
}
