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
    // alert相关
    @State private var loginAlert = false
    @State private var alertText = ""
    
    func alertWith(_ text:String){
        loginAlert=true
        alertText=text
    }
    
    
    var body: some View {
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
                        alertWith("Empty UserName")
                        return
                    }
                    if passwd.count==0{
                        alertWith("Empty Passwd")
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
                                loginAlert=true
                                alertText="User Doesn't Exist"
                            case .wrongPasswd:
                                wrongPasswd=2
                                loginAlert=true
                                alertText="Wrong Passwd"
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
                .alert(alertText, isPresented: $loginAlert){
                    Button("OK"){}
                }
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
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
