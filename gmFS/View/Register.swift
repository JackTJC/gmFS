//
//  Register.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct Register: View {
    @State var userName:String = ""
    @State var password:String = ""
    var body: some View {
        VStack{
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom,20)
            TextField("UserName", text: $userName)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom,20)
            SecureField("Password",text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom,20)
            RegisterButton(color: .green)
        }
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
