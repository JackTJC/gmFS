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
    @State private var loginSuccess = false
    @State private var showingRegister = false
    @State private var showingToast = false
    @State private var toastText = ""
    
    private func toastWithErr(err:String){
        showingToast = true
        toastText = err
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                VStack{
                    Text("Login").font(.largeTitle).bold().padding().foregroundColor(.black)
                    // input field
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
                            self.toastWithErr(err: "empty user name")
                            return
                        }
                        if passwd.count==0{
                            self.toastWithErr(err: "empty passwd")
                            return
                        }
                        BackendService().UserLogin(name: userName, passwd: passwd){resp in
                            if resp.hasBaseResp{
                                switch resp.baseResp.statusCode{
                                case .success:
                                    self.loginSuccess=true
                                    AppManager.setUserCache(resp.userInfo, resp.token)
                                case .userNotFound:
                                    wrongUserName=2
                                    self.toastWithErr(err: "user not found")
                                case .wrongPasswd:
                                    wrongPasswd=2
                                    self.toastWithErr(err: "wrong password")
                                case .commonErr:
                                    self.toastWithErr(err: "internal server error")
                                default:
                                    break
                                }
                            }
                        }failure: { error in
                            self.toastWithErr(err: "internal server error")
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    Button("Register"){
                        showingRegister=true
                    }.frame(width: 300, height: 10, alignment: .trailing)
                    
                    NavigationLink(isActive:self.$loginSuccess){
                        HomeView().navigationBarBackButtonHidden(true)
                    }label: {
                        EmptyView()
                    }
                }
            }
            .toast(isPresented: self.$showingToast, title: self.toastText, state: .failed)
            .fullScreenCover(isPresented: self.$showingRegister){
                RegisterView()
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
