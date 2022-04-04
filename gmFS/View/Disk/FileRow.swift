//
//  FileRow.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct FileRow: View {
    var fileName:String
    var createTimeStamp:UnixTimestamp
    var body: some View {
        HStack{
            Image("document")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            NodeAttrView(nodeName: fileName, nodeCreateTimeStamp: createTimeStamp)
            Spacer()
        }
        .frame( height: 70)
        .scaledToFit()
    }
}

struct FileRow_Previews: PreviewProvider {
    static var previews: some View {
        FileRow(fileName: "file",createTimeStamp: Date.now.unixTimestamp)
    }
}
