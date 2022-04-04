//
//  Profile.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct Profile: View {
    var avatar:Image
    var telephone:String
    var email:String
    var userName:String
    var body: some View {
        VStack{
            avatar
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading, spacing: 0){
                Text("NAME:"+userName)
                    .font(.title)
                Text("TEL:"+telephone)
                    .font(.title)
                Text("E-MAIL"+email)
                    .font(.title)
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(avatar: Image("profile_default_avatar"),telephone: "1234567",email: "12345@qq.com",userName: "JincaiTian")
    }
}
