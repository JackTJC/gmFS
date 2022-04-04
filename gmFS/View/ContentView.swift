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
            NetDisk()
                .tabItem{
                    Label("Disk",image: "disk")
                }.tag(Tab.fileShare)
            MineTab(avatar: Image("default_avatar"))
                .tabItem{
                    Label("Mine",image: "mine")
                }.tag(Tab.mine)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
