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
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("ChangePassword")
                }.background(NavigationLink("",destination: PasswdChgView()).opacity(0))
                HStack{
                    Image("setting")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Settings")
                }.background(NavigationLink("",destination: SettingView()).opacity(0))
                HStack{
                    Image("mine")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("About")
                }.background(NavigationLink("",destination: AboutView()).opacity(0))
                
            }
        }
        .onAppear{
            userInfo = AppManager.getUserCache()
        }
        
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MineTabView(avatar: Image("default_avatar"))
        }
    }
}
