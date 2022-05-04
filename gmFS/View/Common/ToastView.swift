//
//  ToastView.swift
//  gmFS
//
//  Created by jincaitian on 2022/5/4.
//

import SwiftUI
import SimpleToast



class Toast{
    
    enum `Type`:String{
        case saveFile = "Save"
        case shareFile = "Share"
    }
    
    enum State:String{
        case success = "Success"
        case failed = "Failed"
    }
    
    static let succOrFailOpt = SimpleToastOptions(alignment: .bottom, hideAfter: 3, animation: .default, modifierType: .scale)
    
}



extension View{
    func toast(isPresented:Binding<Bool>,type:Toast.`Type`,state:Toast.State) -> some View{
        return self.simpleToast(isPresented: isPresented, options: Toast.succOrFailOpt){
            HStack{
                state == .success ? Image(systemName: "checkmark") : Image(systemName:"xmark")
                Text(type.rawValue)
                Text(state.rawValue)
            }
            .padding()
            .background((state == .success ? Color.blue : Color.red).opacity(0.8))
            .foregroundColor(Color.white)
            .cornerRadius(30)
        }
    }
}

struct ToastView: View {
    @State var toast = false
    @State var saveSuccess = false
    @State var saveFailed = false
    var body: some View {
        VStack{
            Button("SaveSuccess", action:{saveSuccess.toggle()})
            Button("SaveFailed",action: {saveFailed.toggle()})
        }
        .toast(isPresented: self.$saveSuccess, type: .saveFile, state: .success)
        .toast(isPresented: self.$saveFailed, type: .saveFile, state: .failed)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView()
    }
}
