//
//  FileListView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/22.
//

import SwiftUI

struct FileListView: View {
    @State private var subNodes:[Node] = []
    var nodeID:Int64
    var body: some View {
        NavigationView{
            List{
                ForEach(subNodes){node in
                    NavigationLink{
                        NodeDstView(node: node)
                    }label: {
                        NodeLabelView(node: node)
                    }
                }
            }
        }
        .onAppear{
            BackendService().GetNode(nodeID: nodeID){resp in
                subNodes=resp.subNodes
            }failure: { Error in
                
            }
        }
    }
}

struct FileListView_Previews: PreviewProvider {
    static var previews: some View {
        FileListView(nodeID: 1517026803300962304)
    }
}
