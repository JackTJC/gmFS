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
    @State private var showingMCBrowser  = false
    @State private var showingAddFile = false
    @State private var showingInputDirName = false
    @State private var showingRecv = false
    @State private var subNodes:[Node] = []
    @State private var toastSucc = false
    @State private var toastFail = false
    @State private var toatText = ""
    private let userCache = AppManager.getUserCache()
    var nodeID:Int64
    
    private func toastWithErr(err:String){
        self.toastFail.toggle()
        self.toatText=err
    }
    
    private func toastWithSucc(succ:String){
        self.toastSucc.toggle()
        self.toatText = succ
    }
    
    /// 根据node id从server拉取node
    private func fetchNode(){
        BackendService().GetNode(nodeID: nodeID){resp in
            switch resp.baseResp.statusCode{
            case .success:
                break
            default:
                self.toastWithErr(err: "loading failed")
            }
            var copyNodes  = resp.node.subNodeList
            copyNodes.sort{ n1,n2 in
                if n1.nodeType==n2.nodeType{
                    return n1.nodeName<n2.nodeName// 节点名字典序
                }
                return n1.nodeType.rawValue>n2.nodeType.rawValue// 文件夹在上
            }
            subNodes=copyNodes
        }failure: { Error in
            self.toastWithErr(err: "loading failed")
        }
    }
    
    /// 搜索文件
    private func searchFile(){
        let dgstKeyword = EncryptService.word2SHA256Dgst(keyword: self.searchText)
        BackendService().SearchFile(keyword: dgstKeyword){resp in
            switch resp.baseResp.statusCode{
            case .success:
                break
            default:
                self.toastWithErr(err: "search failed")
            }
            var copyNodes = resp.nodeList
            copyNodes.sort{n1,n2 in
                return n1.nodeName<n2.nodeName
            }
            subNodes=copyNodes
        }failure: { err in
            self.toastWithErr(err: "search failed")
        }
    }
    
    /// 处理输入的文件夹名字
    private func handleInputDir(input:String?)->Void{
        if let dirName = input{
            BackendService().CreateDir(dirName: dirName, parentID: nodeID){resp in
                switch resp.baseResp.statusCode{
                case .success:
                    self.toastWithSucc(succ: "add dir success")
                default:
                    self.toastWithErr(err: "add dir failed")
                }
            }failure: { err in
                self.toastWithErr(err: "add dir failed")
            }
        }else{
            self.toastWithErr(err: "add dir failed")
        }
    }
    
    /// 处理导入的文件
    private func handleImportedFile(result:Result<[URL],Error>){
        do {
            guard let selectedFile: URL = try result.get().first else { return }
            if selectedFile.startAccessingSecurityScopedResource(){
                defer {selectedFile.stopAccessingSecurityScopedResource()}
                let fileData = try! Data(contentsOf: selectedFile)
                do{
                    let key = UUID().uuidString
                    let encFileData = try EncryptService.symEncWithId(identity: key, plainText: fileData)
                    let encKey = try EncryptService.symEncWithId(identity: userCache.name, plainText: key.data(using: .utf8)!)
                    let keywords = EncryptService.extractKeyword(fileContent: fileData)
                    BackendService().UploadFile(fileName: selectedFile.lastPathComponent, content: encFileData,parentID: nodeID,key: encKey,keywords: keywords){resp in
                        switch resp.baseResp.statusCode{
                        case .success:
                            self.toastWithSucc(succ: "add file success")
                        default:
                            self.toastWithSucc(succ: "add file failed")
                        }
                    }failure: { err in
                        self.toastWithSucc(succ: "add file failed")
                    }
                }catch{
                    AppManager.logger.error("file content encrypt error")
                }
            }else{
                self.toastWithErr(err: "permission denied")
            }
        } catch {
            self.toastWithErr(err: "read file failed")
        }
    }
    
    var body: some View {
        ZStack {
            List{
                ForEach(subNodes){node in
                    switch node.nodeType{
                    case NodeType.file:
                        FileRowView(fileName: node.nodeName, updateTimeStamp: node.updateTime,nodeID: node.nodeID)
                            .background(NavigationLink("",destination: FileContentView(fileNodeID: node.nodeID)).opacity(0))
                    case NodeType.dir:
                        DirRowView(dirName: node.nodeName, updateTimeStamp: node.updateTime)
                            .background(NavigationLink("",destination: FileTreeView(nodeID: node.nodeID)).opacity(0))
                    default:
                        FileRowView(fileName: "default file", updateTimeStamp: Date.now.unixTimestamp,nodeID:node.nodeID)
                    }
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
                self.handleImportedFile(result: result)
            }
            .alert(isPresented: $showingInputDirName, AlertConfig(title: "Input Directory Name", placeholder: "DirectoryName", accept: "OK", cancel: "Cancel"){input in
                self.handleInputDir(input: input)
            })
            .toast(isPresented: self.$toastFail, title: self.toatText, state: .failed)
            .toast(isPresented: self.$toastSucc, title: self.toatText, state: .success)
            .searchable(text: $searchText,prompt: "Search File")
            .onSubmit(of: .search){
                self.searchFile()
            }
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

