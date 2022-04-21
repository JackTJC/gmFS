//
//  FileTree.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct FileTreeView: View {
    @State private var searchText = ""
    @State private var fileContent = ""
    @State private var showingAlert = false
    @State private var alertText = ""
    @State private var showingMCBrowser  = false
    @State private var showingAddFile = false
    var nodeList:[Node] = []
    private func alertWith(_ text:String){
        showingAlert=true
        alertText=text
    }
    var body: some View {
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
                    FileContentView(fileNodeID: 1)
                }label: {
                    FileRowView(fileName: "Document 1",createTimeStamp: Date.now.unixTimestamp)
                }
                NavigationLink{
                    FileContentView(fileNodeID: 1)
                }label: {
                    FileRowView(fileName: "Document 2",createTimeStamp: Date.now.unixTimestamp)
                }
            }
            .searchable(text: $searchText,prompt: "Search File")
            .toolbar{
                ToolbarItemGroup(placement:.navigationBarTrailing){
                    Toggle(isOn: $showingAddFile){
                        Image(systemName:"plus")
                    }
                    Toggle(isOn: $showingMCBrowser){
                        Image(systemName: "antenna.radiowaves.left.and.right.circle")
                    }
                }
            }
            .sheet(isPresented: $showingMCBrowser){
                ShareView()
            }
        }
        .navigationBarHidden(true)
        .fileImporter(isPresented: $showingAddFile, allowedContentTypes: [.plainText],allowsMultipleSelection: false){result in
            do {
                guard let selectedFile: URL = try result.get().first else { return }
                if selectedFile.startAccessingSecurityScopedResource(){
                    guard let input = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                    defer {selectedFile.stopAccessingSecurityScopedResource()}
                    fileContent = input
                }else{
                    alertWith("No Permission")
                }
            } catch {
                alertWith("Unable to read file contents")
            }
        }
        .alert(alertText, isPresented: $showingAlert, actions: {Button("OK"){}})
    }
}

struct FileTree_Previews: PreviewProvider {
    static var previews: some View {
        FileTreeView()
    }
}

