//
//  SaveDirView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/30.
//

import SwiftUI

struct SaveDirView: View {
    let menuItems: [MyMenu] = [
        MyMenu(name: "Section 1", icon: "", children: [
            MyMenu(name: "Sub section 1", icon: "folder", children : [
                MyMenu(name: "Detail 1", icon: "circle"),
                MyMenu(name: "Detail 2", icon: "circle"),
                MyMenu(name: "Detail 3", icon: "circle")
            ]),
            MyMenu(name: "Sub section 2", icon: "pencil", children : [
                MyMenu(name: "Detail 4", icon: "square"),
                MyMenu(name: "Detail 5", icon: "square")
            ])
        ]),
        MyMenu(name: "Section 2", icon: "", children: [
            MyMenu(name: "Sub section 3", icon: "paperplane.fill", children : [
                MyMenu(name: "Detail 6", icon: "circle"),
                MyMenu(name: "Detail 7", icon: "circle"),
                MyMenu(name: "Detail 8", icon: "circle")
            ]),
            MyMenu(name: "Sub section 4", icon: "archivebox", children : [
                MyMenu(name: "Detail 9", icon: "square"),
                MyMenu(name: "Detail 10", icon: "square")
            ])
        ]),
        MyMenu(name: "Section 3", icon: "doc", children: [
            MyMenu(name: "Sub section 3", icon: "doc")
        ])
    ]
    @State private var selectDir = ""
    var body: some View {
        List {
            ForEach(menuItems) { menuItem in
                Section(header: Text(menuItem.name)) {
                    OutlineGroup(menuItem.children ?? [MyMenu](),
                                 children: \.children) { child in
                        Label(child.name, systemImage: child.icon)
                    }
                }
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct SaveDirView_Previews: PreviewProvider {
    
    static var previews: some View {
        SaveDirView()
    }
}

struct MyMenu: Identifiable {
    var id = UUID()
    let name: String
    let icon: String
    var children: [MyMenu]?
    
    init(name: String, icon: String, children: [MyMenu]? = nil) {
        self.name = name
        self.icon = icon
        self.children = children
    }
}
