//
//  MeView.swift
//  gmFS
//
//  Created by bytedance on 2022/2/20.
//

import SwiftUI

struct MineTabView: View {
    var avatar:Image
    var body: some View {
            VStack{
                avatar
                    .resizable()
                    .clipShape(Circle())
                    .shadow(radius: 7)
                    .frame(width: 150, height: 150)
                Text("UserName")
                    .font(.title)
                Text("tianjincai@hotmail.com")
                List{
                    HStack{
                        Image("key")
                        Text("ChangePassword")
                    }.background(NavigationLink("",destination: PasswdChgView()))
                    HStack{
                        Image("mine")
                        Text("About")
                    }.background(NavigationLink("",destination: AboutView()))
                }
            }
            .navigationBarHidden(true)
        
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MineTabView(avatar: Image("default_avatar"))
        }
    }
}
