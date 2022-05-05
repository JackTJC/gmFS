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
                self.logoutClick.toggle()
            }label:{
                Label("Logout", systemImage: "pip.exit")
            }
        }
        .fullScreenCover(isPresented: self.$logoutClick){
            LoginView()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
