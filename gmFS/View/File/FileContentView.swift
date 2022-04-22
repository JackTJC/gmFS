//
//  FileContentView.swift
//  gmFS
//
//  Created by bytedance on 2022/4/5.
//

import SwiftUI



struct FileContentView: View {
    @State private var content:String = "default content"
    @State private var name:String = "default name"
    
    
    var fileNodeID:Int64
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text(content)
            }
            .onAppear{
                BackendService().GetNode(nodeID: fileNodeID){ resp in
                    content = String(data: resp.node.nodeContent, encoding: .utf8)!
                    name = resp.node.nodeName
                }failure: { Error in
                    
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text(name)
                        .font(.title)
                }
            }
        }
    }
}

struct FileContentView_Previews: PreviewProvider {
    static var previews: some View {
        FileContentView(fileNodeID: 1517032336007368704)
    }
}
