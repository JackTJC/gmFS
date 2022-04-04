//
//  FileTree.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct FileTree: View {
    var body: some View {
        VStack{
            DirRow(dirName: "First Directory",createTimeStamp: Date.now.unixTimestamp)
            DirRow(dirName: "Second Directory",createTimeStamp: Date.now.unixTimestamp)
            DirRow(dirName: "Third Directory",createTimeStamp: Date.now.unixTimestamp)
            FileRow(fileName: "Document 1",createTimeStamp: Date.now.unixTimestamp)
            FileRow(fileName: "Document 2",createTimeStamp: Date.now.unixTimestamp)
            AddButton().offset(x: 120, y: 120)
        }
    }
}

struct FileTree_Previews: PreviewProvider {
    static var previews: some View {
        FileTree()
    }
}

struct AddButton: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("+")
                .font(.system(.largeTitle))
                .frame(width: 77, height: 70)
                .foregroundColor(Color.white)
                .padding(.bottom, 7)
        })
            .background(Color.blue)
            .cornerRadius(38.5)
            .padding()
            .shadow(color: Color.black.opacity(0.3),
                    radius: 3,
                    x: 3,
                    y: 3)
    }
}
