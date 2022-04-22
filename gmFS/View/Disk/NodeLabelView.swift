//
//  NodeView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/22.
//

import SwiftUI

struct NodeLabelView: View {
    var node:Node = Node()
    var body: some View {
        switch node.nodeType{
        case NodeType.file:
            FileRowView(fileName: node.nodeName, updateTimeStamp: node.updateTime)
        case NodeType.dir:
            DirRowView(dirName: node.nodeName, updateTimeStamp: node.updateTime)
        default:
            FileRowView(fileName: "default file", updateTimeStamp: Date.now.unixTimestamp)
        }
    }
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        NodeLabelView()
    }
}
