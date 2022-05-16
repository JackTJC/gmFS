//
//  FileContentView.swift
//  gmFS
//
//  Created by bytedance on 2022/4/5.
//

import SwiftUI



struct FileContentView: View {
    @State private var content:String = "default content"
    @State private var name:String = "default name"
    @EnvironmentObject var shareService:ShareService
    private let userCache =  AppManager.getUserCache()
    @State private var shareSucc = false
    @State private var shareFailed = false
    @State private var showingNoConnected = false
    @State private var key:Data = Data()
    
    
    var fileNodeID:Int64
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack{
                    Text(" ")
                    Text(content)
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear{
            BackendService().GetNode(nodeID: fileNodeID){ resp in
                do{
                    self.key = try EncryptService.symDecWithId(identity: userCache.name, cipherText: resp.node.secretKey)
                    let decFileData = try EncryptService.symDecWithId(identity: String(data: key, encoding: .utf8)!, cipherText: resp.node.nodeContent)
                    content = String(data: decFileData, encoding: .utf8)!
                    name = resp.node.nodeName
                }catch{
                    AppManager.logger.error("content decrypt error")
                }
            }failure: { Error in
                
            }
        }
        .toolbar{
            Button{
                if shareService.getConnectedPeerCnt()==0{
                    self.showingNoConnected.toggle()
                    return
                }
                let sharedFile = SharedFile(fileID: fileNodeID, fileName: name,key: self.key)
                do{
                    try shareService.sendFile(sharedFile: sharedFile)
                    shareSucc.toggle()
                }catch{
                    shareFailed.toggle()
                }
            }label: {
                Label("Share",systemImage: "square.and.arrow.up")
            }
        }
        .toast(isPresented: self.$shareSucc, type: .shareFile, state: .success)
        .toast(isPresented: self.$shareFailed, type: .shareFile, state: .failed)
        .toast(isPresented: self.$showingNoConnected, title: "no device to share", state: .failed)
        .navigationTitle(name)
    }
}

struct FileContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            FileContentView(fileNodeID: 1520730801044459520)
                .environmentObject(ShareService())
        }
    }
}
