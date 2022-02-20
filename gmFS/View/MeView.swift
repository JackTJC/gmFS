//
//  MeView.swift
//  gmFS
//
//  Created by bytedance on 2022/2/20.
//

import SwiftUI

struct MeView: View {
    struct Node{
        var title:String
    }
    private static var navigationNodes:[Node]=[Node(title: "history")]
    var body: some View {
        VStack{
            Image(systemName: "person")
            Text("default name")
//            NavigationView{
//                List(MeView.navigationNodes){node in
//                    NavigationLink(node.title){
//
//                    }
//
//                }
//            }
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MeView()
        }
    }
}
