//
//  ContentView.swift
//  gmFS
//
//  Created by jincaitian on 2022/2/14.
//

import SwiftUI

struct ContentView: View {
    @State private var tab:Tab = .fileShare
    enum Tab{
        case fileShare
        case mine
    }
    var body: some View {
        TabView(selection: self.$tab){
            FileShareView()
                .tabItem{
                    Label("文件分享",systemImage: "shareplay")
                }.tag(Tab.fileShare)
            MeView()
                .tabItem{
                    Label("我",systemImage: "person")
                }.tag(Tab.mine)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
