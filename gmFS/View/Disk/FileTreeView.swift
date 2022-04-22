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
    var nodeList:[Node] = []
    private func alertWith(_ text:String){
        showingAlert=true
        alertText=text
    }
    var body: some View {
        NavigationView{
            List{
                ForEach(subNodes){node in
                    NavigationLink{
                        NodeDstView(node: node)
                    }label: {
                        NodeLabelView(node: node)
                    }
                }
            }
            .searchable(text: $searchText,prompt: "Search File")
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
            .sheet(isPresented: $showingMCBrowser){
                ShareView()
            }
        }
        .onAppear{
            BackendService().GetNode(nodeID: nodeID){resp in
                subNodes=resp.subNodes
            }failure: { Error in
                
            }
        }
        .navigationBarHidden(true)
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
    }
}

struct FileTree_Previews: PreviewProvider {
    static var previews: some View {
        FileTreeView(nodeID: 1517026803300962304)
    }
}

