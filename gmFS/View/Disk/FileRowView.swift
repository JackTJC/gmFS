//
//  FileRow.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct FileRowView: View {
    @EnvironmentObject var shareService:ShareService
    @State private var shareClick = false
    var fileName:String
    var updateTimeStamp:UnixTimestamp
    var nodeID:Int64
    @State private var shareFailed = false
    @State private var showAlert=false
    @State private var alertText=""
    
    func alertWith(text:String){
        showAlert = true
        alertText=text
    }
    
    var body: some View {
        HStack{
            Image("document")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            NodeAttrView(nodeName: fileName, nodeCreateTimeStamp: updateTimeStamp)
            Spacer()
            Menu{
                Button{
                    shareClick.toggle()
                }label:{
                    Label("Share", image: "share")
                }
                Button(action: {}){
                    Label("Delete",image: "close")
                }
            }label: {
                Label("", systemImage: "ellipsis")
            }
        }
        .alert(alertText, isPresented: self.$showAlert){
            Button("OK", action: {})
        }
        .sheet(isPresented: self.$shareClick){
            VStack{
                Text("Sharing")
                List{
                    ForEach(shareService.mcSession.connectedPeers){peer in
                        Button{
                            let nodeIDStr = String(nodeID)
                            let data = nodeIDStr.data(using: .utf8)
                            do{
                                try shareService.mcSession.send(data!, toPeers: [peer], with: .reliable)
                                alertWith(text: "Share Success")
                                AppManager.logger.info("send \(nodeIDStr) to \(peer.displayName)")
                            }catch{
                                alertWith(text: "Share Failed")
                            }
                        }label: {
                            Label(peer.displayName, systemImage: "iphone")
                        }
                    }
                }
            }
        }
    }
}

struct FileRow_Previews: PreviewProvider {
    static var previews: some View {
        FileRowView(fileName: "file",updateTimeStamp: Date.now.unixTimestamp,nodeID: 0)
    }
}
