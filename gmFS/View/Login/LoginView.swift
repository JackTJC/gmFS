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
    @State private var showingWrongPasswd = false
    @State private var showingUserNotExist = false
    @State private var showingEmptyUserName = false
    @State private var showingEmptyPasswd = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                VStack{
                    Text("Login").font(.largeTitle).bold().padding().foregroundColor(.black)
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
                        if userName.count==0{
                            self.showingEmptyUserName.toggle()
                            return
                        }
                        if passwd.count==0{
                            self.showingEmptyPasswd.toggle()
                            return
                        }
                        BackendService().UserLogin(name: userName, passwd: passwd){resp in
                            if resp.hasBaseResp{
                                switch resp.baseResp.statusCode{
                                case .success:
                                    showingLoginScreen=true
                                    AppManager.setUserCache(resp.userInfo, resp.token)
                                case .userNotFound:
                                    wrongUserName=2
                                    self.showingUserNotExist.toggle()
                                case .wrongPasswd:
                                    wrongPasswd=2
                                    self.showingWrongPasswd.toggle()
                                default:
                                    break
                                }
                            }
                        }failure: { error in
                            // TODO error handle
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    Button("Register"){
                        showingRegister=true
                    }.frame(width: 300, height: 10, alignment: .trailing)
                    // to homepage
                    NavigationLink(isActive: $showingLoginScreen){
                        HomeView()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    }label: {
                        EmptyView()
                    }.isDetailLink(false)
                    // to register
                    NavigationLink(isActive:$showingRegister){
                        RegisterView()
                    }label: {
                        EmptyView()
                    }
                    .isDetailLink(false)
                }
                .toast(isPresented: self.$showingEmptyPasswd, title: "Empty Password", state: .failed)
                .toast(isPresented: self.$showingEmptyUserName, title: "Empty User Name", state: .failed)
                .toast(isPresented: self.$showingUserNotExist, title: "User Not Exist", state: .failed)
                .toast(isPresented: self.$showingWrongPasswd, title: "Passwd Wrong", state: .failed)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
