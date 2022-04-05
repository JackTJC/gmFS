//
//  LoginView.swift
//  gmFS
//
//  Created by bytedance on 2022/4/4.
//

import SwiftUI

struct LoginView: View {
    @State private var userName = ""
    @State private var passwd = ""
    @State private var wrongUserName = 0
    @State private var wrongPasswd = 0
    @State private var showingLoginScreen = false
    @State private var showingRegister = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                VStack{
                    Text("Login").font(.largeTitle).bold().padding()
                    TextField("Username",text: $userName)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUserName))
                    SecureField("Password",text: $passwd)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPasswd))
                    Button("Login"){
                        // Login logic
                        showingLoginScreen=true
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    Button("Register"){
                        showingRegister=true
                    }.frame(width: 300, height: 10, alignment: .trailing)
                    NavigationLink(destination: Text("Logined"),isActive: $showingLoginScreen){
                        EmptyView()
                    }
                    NavigationLink(destination: RegisterView(), isActive: $showingRegister){
                        EmptyView()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
