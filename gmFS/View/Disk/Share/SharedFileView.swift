//
//  SharedFileView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/30.
//

import SwiftUI

struct SharedFileView: View {
    @StateObject var shareSrv:ShareService
    var sharedFiles:[SharedFileModel]
    @State private var saveClick = false
    @State private var selectedFile:SharedFileModel = SharedFileModel(fileID: 0, fileName: "", key: Data())
    @State var saveSucc:Bool = false
    private let userCache = AppManager.getUserCache()
    
    var body: some View {
        List{
            ForEach(self.shareSrv.recvFiles){file in
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
                DirTreeView(rootNodeId: userCache.rootNode,sharedFile: self.$selectedFile,showingDirTree: self.$saveClick,saveSucc: self.$saveSucc)
            }
        }
        .toast(isPresented: self.$saveSucc, type: .saveFile, state: .success)
        .navigationBarHidden(true)
    }
}

struct SharedFileView_Previews: PreviewProvider {
    static var files = [SharedFileModel(fileID: 1, fileName: "123",key: Data()),SharedFileModel(fileID: 2, fileName: "test",key: Data())]
    static var previews: some View {
        NavigationView{
            SharedFileView(shareSrv:  ShareService(), sharedFiles: files)
        }
    }
}
