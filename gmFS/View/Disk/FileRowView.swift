//
//  FileRow.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct FileRowView: View {
    var fileName:String
    var updateTimeStamp:UnixTimestamp
    var body: some View {
        HStack{
            Image("document")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            NodeAttrView(nodeName: fileName, nodeCreateTimeStamp: updateTimeStamp)
            Spacer()
            Menu{
                Button(action: {}){
                    Label("Share", image: "share")
                }
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
        FileRowView(fileName: "file",updateTimeStamp: Date.now.unixTimestamp)
    }
}
