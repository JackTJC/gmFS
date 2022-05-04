//
//  FileTree.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI
import MultipeerConnectivity

struct FileTreeView: View {
    @EnvironmentObject var shareService:ShareService
    @State private var searchText = ""
    @State private var showingAlert = false
    @State private var alertText = ""
    @State private var showingMCBrowser  = false
    @State private var showingAddFile = false
    @State private var showingInputDirName = false
    @State private var showingRecv = false
    @State private var subNodes:[Node] = []
    @State private var showingLoading = true
    private let userCache = AppManager.getUserCache()
    var nodeID:Int64
    
    // 弹出提醒
    private func alertWith(_ text:String){
        showingAlert=true
        alertText=text
    }
    
    // 根据node id从server拉取node
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
        ZStack {
            List{
                ForEach(subNodes){node in
                    NodeView(node: node)
                }
            }
            .sheet(isPresented: $showingMCBrowser){
                BrowserViewControllerRepresent(didFinish: self.$showingMCBrowser, wasCanceled: self.$showingMCBrowser,shareService: self.shareService)
            }
            .sheet(isPresented: $showingRecv){
                SharedFileView(sharedFiles: shareService.sharedFileList)
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
                        do{
                            let key = UUID().uuidString
                            let encFileData = try EncryptService.aesEncrypt(identity: key, plainText: fileData)
                            let encKey = try EncryptService.aesEncrypt(identity: userCache.name, plainText: key.data(using: .utf8)!)
                            BackendService().UploadFile(fileName: selectedFile.lastPathComponent, content: encFileData,parentID: nodeID,key: encKey){resp in
                                // TODO response handle
                            }failure: { err in
                                // TODO err handle
                            }
                        }catch{
                            AppManager.logger.error("file content encrypt error")
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
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Menu{
                        Button("File", action: {showingAddFile.toggle()})
                        Button("Directory",action: {showingInputDirName.toggle()})
                    }label: {
                        Label("AddFile", systemImage: "plus")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button(action: {showingRecv.toggle()}){
                        Label("", systemImage: "arrow.left.arrow.right")
                    }
                    Menu{
                        Button("Join Session", action: {showingMCBrowser.toggle()})
                        Button("Host Session",action: {shareService.startHostNeayBy()})
                    }label: {
                        Label("Session", systemImage: "antenna.radiowaves.left.and.right.circle")
                    }
                }
            }
            .searchable(text: $searchText,prompt: "Search File")
        }
    }
}

struct FileTree_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            FileTreeView(nodeID: 1517026803300962304)
        }
    }
}

