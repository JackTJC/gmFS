//
//  RegisterView.swift
//  gmFS
//
//  Created by bytedance on 2022/4/4.
//

import SwiftUI

struct RegisterView: View {
    @State private var userName = ""
    @State private var passwd = ""
    @State private var email = ""
    @State private var registerSuccess = false
    @State private var showingToast = false
    @State private var taostText = ""
    
    private func toastErr(err:String){
        showingToast = true
        taostText = err
    }
    
    var body: some View {
        ZStack{
            Color.blue.ignoresSafeArea()
            Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
            Circle().scale(1.35).foregroundColor(.white)
            VStack{
                Text("Register").font(.largeTitle).bold().padding().foregroundColor(.black)
                TextField("Username",text: $userName)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                TextField("Email",text: $email)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .cornerRadius(10)
                SecureField("Password",text: $passwd)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                Button("Register"){
                    if !userName.isValidUserName{
                        self.toastErr(err: "invalid user name")
                        return
                    }
                    if !passwd.isValidPasswd{
                        self.toastErr(err: "invalid password")
                        return
                    }
                    if !email.isValidEmail{
                        self.toastErr(err: "invalid email")
                        return
                    }
                    BackendService().UserRegister(name: userName, passwd: passwd, email: email){ resp in
                        if resp.hasBaseResp{
                            switch resp.baseResp.statusCode{
                            case .userExist:
                                self.toastErr(err: "user have existed")
                            case .commonErr:
                                self.toastErr(err: "internal server error")
                            case .success:
                                registerSuccess=true
                            default:
                                break
                            }
                        }
                    }failure: { error in
                        
                    }
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                NavigationLink(destination: LoginView(),isActive: $registerSuccess){
                    EmptyView()
                }
            }
        }
        .toast(isPresented: self.$showingToast, title: self.taostText, state: .failed)
        .toast(isPresented: self.$registerSuccess, type: .register, state: .success)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
