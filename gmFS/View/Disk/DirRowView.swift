//
//  DirRow.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct DirRowView: View {
    var dirName:String
    var createTimeStamp:UnixTimestamp
    
    var body: some View {
        HStack{
            Image("folder")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            NodeAttrView(nodeName: dirName, nodeCreateTimeStamp: createTimeStamp)
            Spacer()
        }
        .frame(height: 70)
        .scaledToFit()
    }
}

struct DirRow_Previews: PreviewProvider {
    static var previews: some View {
        DirRowView(dirName: "First Firectory",createTimeStamp: Date.now.unixTimestamp)
    }
}

struct NodeAttrView: View {
    var nodeName:String
    var nodeCreateTimeStamp:UnixTimestamp
    var createTimeStr:String {
        let createTime = nodeCreateTimeStamp.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from:createTime)
    }
    var body: some View {
        VStack(alignment: .leading){
            Text(nodeName)
                .font(.title3)
            Text(createTimeStr)
                .font(.caption)
                .fontWeight(.regular)
                .foregroundColor(Color.gray)
        }
    }
}