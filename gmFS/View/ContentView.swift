//
//  ContentView.swift
//  gmFS
//
//  Created by jincaitian on 2022/2/14.
//

import SwiftUI
import SimpleToast

struct ContentView: View {
    private var isLogined = AppManager.isLogined()
    private let toastOptions = SimpleToastOptions(
        hideAfter: 3
    )
    @EnvironmentObject var shareService:ShareService
    
    var body: some View {
        Group{
            if isLogined{
                HomeView()
            }else{
                LoginView()
            }
        }
        .simpleToast(isPresented: $shareService.receiveFile, options: toastOptions){// 收到文件弹出提醒
            HStack {
                Image(systemName: "square.and.arrow.down")
                Text(shareService.toastMsg)
            }
            .padding()
            .background(Color.blue.opacity(0.8))
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ShareService())
    }
}
