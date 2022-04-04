//
//  Login.swift
//  gmFS
//
//  Created by bytedance on 2022/3/19.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)


struct Login: View {
    @State var userName:String = ""
    @State var password:String = ""
    var body: some View {
        VStack{
            WelcomText()
            LoginImage()
            TextField("UserName", text: $userName)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom,20)
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom,20)
            HStack{
                LoginButton()
                RegisterButton(color: .gray)
            }
        }
        .padding()
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
            .padding(.bottom,25)
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

struct RegisterButton: View {
    var color:Color
    var body: some View {
        Button{
            print("register button click")
        }label: {
            Text("REGISTER")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 180, height: 60)
                .background(color)
                .cornerRadius(15.0)
        }
    }
}

struct LoginButton: View {
    var body: some View {
        Button{
            print("login button click")
        }label: {
            Text("LOGIN")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 180, height: 60)
                .background(Color.green)
                .cornerRadius(15.0)
        }
    }
}
