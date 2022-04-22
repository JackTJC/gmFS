//
//  NetDisk.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct NetDiskView: View {
    @State var searchQuery = ""
    var body: some View {
        VStack {
            FileTreeView(nodeID: 1)
        }
    }
}

struct NetDisk_Previews: PreviewProvider {
    static var previews: some View {
        NetDiskView()
    }
}
