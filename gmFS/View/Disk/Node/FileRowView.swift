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
    @State private var shareSucc = false
    @State private var shareFailed = false
    let toastOpt = SimpleToastOptions(alignment: .bottom, hideAfter: 3, animation: .default, modifierType: .scale)
    
    var body: some View {
        HStack{
            Image("document")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            NodeAttrView(nodeName: fileName, nodeCreateTimeStamp: updateTimeStamp)
            Spacer()
            Menu{
                Button{
                    let sharedFile = SharedFile(fileID: nodeID, fileName: fileName)
                    do{
                        try shareService.sendFile(sharedFile: sharedFile)
                        shareSucc.toggle()
                    }catch{
                        shareFailed.toggle()
                    }
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
        .simpleToast(isPresented: self.$shareSucc, options: toastOpt){
            HStack{
                Image(systemName: "paperplane")
                Text("Share Success")
            }
            .padding()
            .background(Color.blue.opacity(0.8))
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }
        .simpleToast(isPresented: self.$shareFailed, options: toastOpt){
            HStack{
                Text("Share Filead")
            }
            .padding()
            .background(Color.red.opacity(0.8))
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }
    }
}

struct FileRow_Previews: PreviewProvider {
    static var previews: some View {
        FileRowView(fileName: "file",updateTimeStamp: Date.now.unixTimestamp,nodeID: 0)
            .environmentObject(ShareService())
    }
}
