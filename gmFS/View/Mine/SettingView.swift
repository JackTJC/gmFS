//
//  SettingView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/26.
//

import SwiftUI

struct SettingView: View {
    @State private var logoutClick = false
    var body: some View {
        List{
            Button{
                AppManager.delUserCache()
                logoutClick = true
            }label:{
                Label("Logout", systemImage: "pip.exit")
            }.background{
                NavigationLink(""){
                    LoginView().navigationBarBackButtonHidden(true)
                }.opacity(0)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
