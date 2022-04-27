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
    @State private var showingAlert = false
    @State private var alerText = ""
    @State private var registerSuccess = false
    func alertWith(_ text:String){
        showingAlert=true
        alerText=text
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
                        alertWith("Invalid User Name")
                        return
                    }
                    if !passwd.isValidPasswd{
                        alertWith("Invalid Password")
                        return
                    }
                    if !email.isValidEmail{
                        alertWith("Invalid Email")
                        return
                    }
                    BackendService().UserRegister(name: userName, passwd: passwd, email: email){ resp in
                        if resp.hasBaseResp{
                            switch resp.baseResp.statusCode{
                            case .userExist:
                                showingAlert=true
                                alerText="User Have Exist"
                            case .commonErr:
                                showingAlert = true
                                alerText = "Internal Server Error"
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
                .alert(alerText, isPresented: $showingAlert){
                    Button("OK"){}
                }
                NavigationLink(destination: LoginView(),isActive: $registerSuccess){
                    EmptyView()
                }
            }
        }
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
