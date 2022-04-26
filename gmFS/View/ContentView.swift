//
//  ContentView.swift
//  gmFS
//
//  Created by jincaitian on 2022/2/14.
//

import SwiftUI

struct ContentView: View {
    @State var isLogined = AppManager.isLogined()
    
    var body: some View {
        Group{
            if isLogined{
                HomeView()
            }else{
                NavigationView{
                    LoginView()
                        .navigationBarHidden(true)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
