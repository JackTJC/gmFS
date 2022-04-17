//
//  HomeView.swift
//  gmFS
//
//  Created by bytedance on 2022/4/14.
//

import SwiftUI

struct HomeView: View {
    @State private var tab:Tab = .fileShare
    enum Tab{
        case fileShare
        case mine
    }
    var body: some View {
        TabView(selection: self.$tab){
            NetDiskView()
                .tabItem{
                    Label("Disk",image: "disk")
                }.tag(Tab.fileShare)
            MineTabView(avatar: Image("default_avatar"))
                .tabItem{
                    Label("Mine",image: "mine")
                }.tag(Tab.mine)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
