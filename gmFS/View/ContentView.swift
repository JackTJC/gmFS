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
        if isLogined{
            HomeView()
                .simpleToast(isPresented: $shareService.receiveFile, options: toastOptions){// receive file toast
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Text(shareService.toastMsg)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                }
        }else{
            LoginView()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ShareService())
    }
}
