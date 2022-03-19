//
//  Login.swift
//  gmFS
//
//  Created by bytedance on 2022/3/19.
//

import SwiftUI

struct Login: View {
    var body: some View {
        VStack{
            WelcomText()
            LoginImage()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

struct LoginImage: View {
    var body: some View {
        Image("login_icon")
            .resizable()
            .aspectRatio( contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom,75)
    }
}

struct WelcomText: View {
    var body: some View {
        Text("Welcome")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom,20)
    }
}
