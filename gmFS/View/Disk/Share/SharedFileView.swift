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
    var body: some View {
        List{
            ForEach(sharedFiles){file in
                HStack{
                    Image(systemName: "doc.text")
                    Text(file.fileName)
                    Spacer()
                    Menu{
                        Button(action: {saveClick.toggle()}){
                            Label("Save", systemImage: "square.and.arrow.down")
                        }
                    }label: {
                        Label("", systemImage: "ellipsis")
                    }
                    
                }
            }
        }
    }
}

struct SharedFileView_Previews: PreviewProvider {
    static var files = [SharedFile(fileID: 1, fileName: "123"),SharedFile(fileID: 2, fileName: "test")]
    static var previews: some View {
        SharedFileView(sharedFiles: files)
    }
}
