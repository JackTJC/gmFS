//
//  FileTree.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI
import MultipeerConnectivity

struct FileTreeView: View {
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
        .sheet(isPresented: $showingMCBrowser){
            ShareView()
        }
        .onAppear{
            fetchNode()
        }
        .refreshable {
            fetchNode()
        }
        .fileImporter(isPresented: $showingAddFile, allowedContentTypes: [.plainText],allowsMultipleSelection: false){result in
            do {
                guard let selectedFile: URL = try result.get().first else { return }
                if selectedFile.startAccessingSecurityScopedResource(){
                    defer {selectedFile.stopAccessingSecurityScopedResource()}
                    let fileData = try! Data(contentsOf: selectedFile)
                    BackendService().UploadFile(fileName: selectedFile.lastPathComponent, content: fileData,parentID: nodeID){resp in
                        // TODO response handle
                    }failure: { err in
                        // TODO err handle
                    }
                }else{
                    alertWith("No Permission")
                }
            } catch {
                alertWith("Unable to read file contents")
            }
        }
        .alert(alertText, isPresented: $showingAlert, actions: {Button("OK"){}})
        .alert(isPresented: $showingInputDirName, AlertConfig(title: "Input Directory Name", placeholder: "DirectoryName", accept: "OK", cancel: "Cancel"){input in
            if let dirName = input{
                BackendService().CreateDir(dirName: dirName, parentID: nodeID){resp in
                    // TODO resp handle
                }failure: { err in
                    // TODO err handle
                }
            }else{
                // do nothing
            }
        })
        .toolbar{
            ToolbarItemGroup(placement:.navigationBarTrailing){
                Menu{
                    Button("File", action: {showingAddFile=true})
                    Button("Directory",action: {showingInputDirName=true})
                }label: {
                    Label("AddFile", systemImage: "plus")
                }
                Menu{
                    Button("Join Session", action: {showingMCBrowser=true})
                    Button("Host Session",action: {shareService.startHost()})
                }label: {
                    Label("Session", systemImage: "antenna.radiowaves.left.and.right.circle")
                }
            }
        }
        .searchable(text: $searchText,prompt: "Search File")
    }
}

struct FileTree_Previews: PreviewProvider {
    static var previews: some View {
        FileTreeView(nodeID: 1517026803300962304)
    }
}

