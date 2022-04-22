//
//  NodeLinkView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/22.
//

import SwiftUI

struct NodeDstView: View {
    var node:Node = Node()
    var body: some View {
        switch  node.nodeType {
        case NodeType.file:
            FileContentView(fileNodeID: node.nodeID)
        case NodeType.dir:
            FileTreeView(nodeID: node.nodeID)
        default:
            Text("empty view")
        }
    }
}

struct NodeLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NodeDstView()
    }
}
