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
    @State private var selectedFileID:Int64 = 0
    @State private var selectedFile:SharedFile?
    private let userCache = AppManager.getUserCache()
    
    var body: some View {
        
        List{
            ForEach(sharedFiles){file in
                HStack{
                    Image(systemName: "doc.text")
                    Text(file.fileName)
                    Spacer()
                    Button{
                        selectedFileID = file.fileID
                        saveClick.toggle()
                    }label:{
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: self.$saveClick){
            NavigationView{
                DirTreeView(rootNodeId: userCache.rootNode,operateID: self.$selectedFileID)
            }
        }
        .navigationBarHidden(true)
    }
}

struct SharedFileView_Previews: PreviewProvider {
    static var files = [SharedFile(fileID: 1, fileName: "123"),SharedFile(fileID: 2, fileName: "test")]
    static var previews: some View {
        NavigationView{
            SharedFileView(sharedFiles: files)
        }
    }
}
