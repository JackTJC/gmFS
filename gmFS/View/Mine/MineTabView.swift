//
//  MeView.swift
//  gmFS
//
//  Created by bytedance on 2022/2/20.
//

import SwiftUI

struct MineTabView: View {
    var avatar:Image
    @State private var userInfo:UserInfoModel = AppManager.getUserCache()
    var body: some View {
            VStack{
                avatar
                    .resizable()
                    .clipShape(Circle())
                    .shadow(radius: 7)
                    .frame(width: 150, height: 150)
                Text(userInfo.name)
                    .font(.title)
                Text(userInfo.email)
                List{
                    HStack{
                        Image("key")
                        Text("ChangePassword")
                    }.background(NavigationLink("",destination: PasswdChgView()))
                    HStack{
                        Image("mine")
                        Text("About")
                    }.background(NavigationLink("",destination: AboutView()))
                    HStack{
                        Image("setting")
                        Text("Settings")
                    }.background(NavigationLink("",destination: SettingView()))
                }
            }
            .onAppear{
                userInfo = AppManager.getUserCache()
            }
        
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MineTabView(avatar: Image("default_avatar"))
        }
    }
}
