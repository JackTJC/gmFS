//
//  Toast.swift
//  gmFS
//
//  Created by jincaitian on 2022/5/4.
//

import SimpleToast
import SwiftUI

class Toast{
    static let succOrFailOpt = SimpleToastOptions(alignment: .bottom, hideAfter: 3, animation: .default, modifierType: .scale)
}

enum ToastType{
    case saveFile
    case shareFile
}

extension View{
    private func commonToast(isPresented:Binding<Bool>)->some View{
        return self.simpleToast(isPresented: isPresented, options: Toast.succOrFailOpt){
            HStack{
                Image(systemName: "paperplane")
                Text("Share Success")
            }
            .padding()
            .background(Color.blue.opacity(0.8))
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }
        
    }
}
