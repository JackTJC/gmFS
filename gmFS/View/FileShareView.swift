//
//  FileShareView.swift
//  gmFS
//
//  Created by bytedance on 2022/2/20.
//

import SwiftUI

struct FileShareView: View {
    @EnvironmentObject var shareService:ShareService
    @State private var showingConnection = false
    @State private var isImporting = false
    @State private var document: InputDoument = InputDoument(input: "")
    var body: some View {
        NavigationView{
            VStack{
                Text("imported file")
                Text(self.document.input)
            }
            .navigationTitle("Share File")
            .toolbar{
                HStack{
                    Button{
                        self.isImporting=true
                    } label: {
                        Label("add file",systemImage: "plus")
                    }
                    Divider()
                    Button{
                        self.showingConnection.toggle()
                    }label: {
                        // when connect use
                        // antenna.radiowaves.left.and.right.circle.fill
                        Label("connect",systemImage: "antenna.radiowaves.left.and.right.circle")
                    }
                }
                
            }.sheet(isPresented: self.$showingConnection, onDismiss: {self.showingConnection=false}){
                Text("Test")
            }
            .fileImporter(isPresented: self.$isImporting, allowedContentTypes: [.plainText], allowsMultipleSelection: true){result in
                do {
                    guard let selectedFile: URL = try result.get().first else { return }
                    if selectedFile.startAccessingSecurityScopedResource(){
                        guard let input = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                        defer {selectedFile.stopAccessingSecurityScopedResource()}
                        document.input = input
                    }else{
                        print("No permission")
                    }
                    
                } catch {
                    // Handle failure.
                    print("Unable to read file contents")
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct FileShareView_Previews: PreviewProvider {
    static var previews: some View {
        FileShareView().environmentObject(ShareService())
    }
}
