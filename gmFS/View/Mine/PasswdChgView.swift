//
//  ChangePassword.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct PasswdChgView: View {
    @State private var oldPasswd = ""
    @State private var newPasswd  = ""
    @State private var wrongOld = 0
    
    var body: some View {
        VStack {
            VStack(alignment:.leading) {
                Text("Change Password")
                    .font(.title)
                SecureField("Old Password",text: $oldPasswd)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongOld))
                SecureField("New Password",text: $newPasswd)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
            }
            Button("Change"){
                //TODO 修改密码逻辑
            }
            .frame(width: 150, height: 50)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        PasswdChgView()
    }
}
