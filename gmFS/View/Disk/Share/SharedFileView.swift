//
//  SharedFileView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/30.
//

import SwiftUI

struct SharedFileView: View {
    var sharedFiles:[SharedFile]
    @State private var saveClick = false
    @State private var selectedFile:SharedFile = SharedFile(fileID: 0, fileName: "", key: Data())
    private let userCache = AppManager.getUserCache()
    
    var body: some View {
        List{
            ForEach(sharedFiles){file in
                HStack{
                    Image(systemName: "doc.text")
                    Text(file.fileName)
                    Spacer()
                    Button{
                        selectedFile = file
                        saveClick.toggle()
                    }label:{
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: self.$saveClick){
            NavigationView{
                DirTreeView(rootNodeId: userCache.rootNode,sharedFile: self.$selectedFile)
            }
        }
        .navigationBarHidden(true)
    }
}

struct SharedFileView_Previews: PreviewProvider {
    static var files = [SharedFile(fileID: 1, fileName: "123",key: Data()),SharedFile(fileID: 2, fileName: "test",key: Data())]
    static var previews: some View {
        NavigationView{
            SharedFileView(sharedFiles: files)
        }
    }
}
