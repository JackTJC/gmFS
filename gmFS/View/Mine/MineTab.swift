//
//  MeView.swift
//  gmFS
//
//  Created by bytedance on 2022/2/20.
//

import SwiftUI

struct MineTab: View {
    var avatar:Image
    var body: some View {
        NavigationView{
            VStack{
                avatar
                    .resizable()
                    .clipShape(Circle())
                    .shadow(radius: 7)
                    .frame(width: 150, height: 150)
                Text("UserName")
                        .font(.largeTitle)
                    NavigationLink{
                       Profile(avatar: Image("profile_default_avatar"), telephone: "123", email: "123@qq.com", userName: "123")
                    }label: {
                        ProfileRow()
                    }
                NavigationLink{
                    ChangePassword()
                }label: {
                    ChgPasswdRow()
                }
            }
        }
        
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MineTab(avatar: Image("default_avatar"))
        }
    }
}
