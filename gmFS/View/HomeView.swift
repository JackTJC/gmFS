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
            NavigationView{
                FileTreeView(nodeID: 1517026803300962304)
            }
            .tabItem{
                Label("Disk",systemImage: "folder")
            }.tag(Tab.fileShare)
            NavigationView{
                MineTabView(avatar: Image("default_avatar"))
            }
            .tabItem{
                Label("Mine",systemImage: "person")
            }.tag(Tab.mine)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
