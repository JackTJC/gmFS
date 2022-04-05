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
        NavigationView{
            ZStack {
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                VStack{
                    avatar
                        .resizable()
                        .clipShape(Circle())
                        .shadow(radius: 7)
                        .frame(width: 150, height: 150)
                    Text("UserName")
                        .font(.title)
                    Text("tianjincai@hotmail.com")
                    NavigationLink{
                        PasswdChgView()
                    }label: {
                        PasswdChgRowView()
                    }
                    NavigationLink{
                        AboutView(avatar: Image("profile_default_avatar"), telephone: "123", email: "123@qq.com", userName: "123")
                    }label: {
                        AboutRowView()
                    }
                }
            }
            .navigationBarHidden(true)
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
