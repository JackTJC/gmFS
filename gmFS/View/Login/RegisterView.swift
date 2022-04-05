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
    @State private var showginRegister = false
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                VStack{
                    Text("Register").font(.largeTitle).bold().padding()
                    TextField("Username",text: $userName)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        
                    SecureField("Password",text: $passwd)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    Button("Register"){
                        // Login logic
                        showginRegister=true
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    NavigationLink(destination: Text("DoingRegister"),isActive: $showginRegister){
                        EmptyView()
                    }
                    
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
