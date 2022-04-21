//
//  FileContentView.swift
//  gmFS
//
//  Created by bytedance on 2022/4/5.
//

import SwiftUI



struct FileContentView: View {
    @State private var content:String = ""
    @State private var name:String = ""
    var fileNodeID:Int64
    var body: some View {
        VStack(alignment: .leading){
            Text(name)
                .font(.title)
            Text(content)
        }
        .onAppear{
            BackendService().GetNode(nodeID: fileNodeID){ resp in
                content = String(data: resp.node.nodeContent, encoding: .utf8)!
                name = resp.node.nodeName
            }failure: { Error in
                
            }
        }
        
    }
}

struct FileContentView_Previews: PreviewProvider {
    static var previews: some View {
        FileContentView(fileNodeID: 1517032336007368704)
    }
}
