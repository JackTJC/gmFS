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
    private let userCache =  AppManager.getUserCache()
    
    var fileNodeID:Int64
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack{
                    Text(" ")
                    Text(content)
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear{
            BackendService().GetNode(nodeID: fileNodeID){ resp in
                do{
                    let decFileData = try EncryptService.aesDecrypt(identity: userCache.name, cipherText: resp.node.nodeContent)
                    content = String(data: decFileData, encoding: .utf8)!
                    name = resp.node.nodeName
                }catch{
                    AppManager.logger.error("content decrypt error")
                }
            }failure: { Error in
                
            }
        }
        .navigationTitle(name)
    }
}

struct FileContentView_Previews: PreviewProvider {
    static var previews: some View {
        FileContentView(fileNodeID: 1520730801044459520)
    }
}
