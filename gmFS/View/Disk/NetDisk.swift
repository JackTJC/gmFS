//
//  NetDisk.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct NetDisk: View {
    @State var searchQuery = ""
    var body: some View {
        VStack {
            FileTree()
        }
    }
}

struct NetDisk_Previews: PreviewProvider {
    static var previews: some View {
        NetDisk()
    }
}
