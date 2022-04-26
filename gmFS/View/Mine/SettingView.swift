//
//  SettingView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/26.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        List{
            Button{
                AppManager.delUserCache()
            }label:{
                Label("Logout", systemImage: "pip.exit")
            }
        }
      
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
