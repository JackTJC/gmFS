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
        .popover(isPresented: self.$shareClick){
            VStack{
            Text("Sharing")
                List{
                    ForEach(shareService.mcSession.connectedPeers){peer in
                        Button{
                            let nodeIDStr = String(nodeID)
                            AppManager.logger.info("send \(nodeIDStr) to \(peer.displayName)")
                            let data = nodeIDStr.data(using: .utf8)
                            try! shareService.mcSession.send(data!, toPeers: [peer], with: .reliable)
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
