//
//  FileTree.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct FileTreeView: View {
    var body: some View {
        VStack{
            Text("JincaiTian's Disk")
                .font(.title)
            NavigationView{
                List{
                    NavigationLink{
                        FileTreeView()
                    }label: {
                        DirRowView(dirName: "First Directory",createTimeStamp: Date.now.unixTimestamp)
                    }
                    NavigationLink{
                        FileTreeView()
                    }label: {
                        DirRowView(dirName: "Second Directory",createTimeStamp: Date.now.unixTimestamp)
                    }
                    NavigationLink{
                        FileTreeView()
                    }label: {
                        DirRowView(dirName: "Third Directory",createTimeStamp: Date.now.unixTimestamp)
                    }
                    NavigationLink{
                        FileContentView()
                    }label: {
                        FileRowView(fileName: "Document 1",createTimeStamp: Date.now.unixTimestamp)
                    }
                    NavigationLink{
                        FileContentView()
                    }label: {
                        FileRowView(fileName: "Document 2",createTimeStamp: Date.now.unixTimestamp)
                    }
                }
                .navigationBarHidden(true)
            }
            //            AddButton().offset(x: 120, y: 120)
        }
    }
}

struct FileTree_Previews: PreviewProvider {
    static var previews: some View {
        FileTreeView()
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
