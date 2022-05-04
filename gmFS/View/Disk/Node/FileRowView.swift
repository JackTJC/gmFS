//
//  FileRow.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI
import SimpleToast

struct FileRowView: View {
    @EnvironmentObject var shareService:ShareService
    @State private var shareClick = false
    var fileName:String
    var updateTimeStamp:UnixTimestamp
    var nodeID:Int64
        let toastOpt = SimpleToastOptions(alignment: .bottom, hideAfter: 3, animation: .default, modifierType: .scale)
    
    var body: some View {
        HStack{
            Image("document")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            NodeAttrView(nodeName: fileName, nodeCreateTimeStamp: updateTimeStamp)
            Spacer()
            Menu{
                Button(action: {}){
                    Label("Delete",image: "close")
                }
            }label: {
                Label("", systemImage: "ellipsis")
            }
        }

    }
}

struct FileRow_Previews: PreviewProvider {
    static var previews: some View {
        FileRowView(fileName: "file",updateTimeStamp: Date.now.unixTimestamp,nodeID: 0)
            .environmentObject(ShareService())
    }
}
