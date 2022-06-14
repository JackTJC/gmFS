//
//  ToastView.swift
//  gmFS
//
//  Created by jincaitian on 2022/5/4.
//

import SwiftUI
import SimpleToast



class Toast{
    
    /// Toast类型枚举
    enum `Type`:String{
        case saveFile = "Save"
        case shareFile = "Share"
        case login = "Login"
        case register = "Register"
        case readFile = "Read File"
        case add = "Add"
        case load = "Load"
        case startHost = "Start Host"
    }
    
    /// Toast状态枚举
    enum State:String{
        case success = "Success"
        case failed = "Failed"
    }
    
    /// toast选项
    static let succOrFailOpt = SimpleToastOptions(alignment: .bottom, hideAfter: 3, animation: .default, modifierType: .scale)
    
    /// 根据类型和状态获取toast
    static func getToastContent(type:Toast.`Type`,state:Toast.State) -> some View{
        return  HStack{
            state == .success ? Image(systemName: "checkmark") : Image(systemName:"xmark")
            Text(type.rawValue)
            Text(state.rawValue)
        }
        .padding()
        .background((state == .success ? Color.blue : Color.red).opacity(0.8))
        .foregroundColor(Color.white)
        .cornerRadius(30)
    }
    /// 根据标题和状态获取toast
    static func getToastContent(title:String,state:Toast.State)->some View{
        return  HStack{
            state == .success ? Image(systemName: "checkmark") : Image(systemName:"xmark")
            Text(title)
        }
        .padding()
        .background((state == .success ? Color.blue : Color.red).opacity(0.8))
        .foregroundColor(Color.white)
        .cornerRadius(30)
    }
}


/// 拓展view使其支持toast
extension View{
    func toast(isPresented:Binding<Bool>,type:Toast.`Type`,state:Toast.State) -> some View{
        return self.simpleToast(isPresented: isPresented, options: Toast.succOrFailOpt){
            Toast.getToastContent(type: type, state: state)
        }
    }
    
    func toast(isPresented:Binding<Bool>,title:String,state:Toast.State) -> some View{
        return self.simpleToast(isPresented: isPresented, options: Toast.succOrFailOpt){
            Toast.getToastContent(title: title, state: state)
        }
    }
    
    func toast(isPresented:Binding<Bool>,type:Toast.`Type`,state:Toast.State,onDismiss:(()->Void)?)->some View{
        return self.simpleToast(isPresented: isPresented, options: Toast.succOrFailOpt, onDismiss: onDismiss){
            Toast.getToastContent(type: type, state: state)
        }
    }
    
    func toast(isPresented:Binding<Bool>,title:String,state:Toast.State,onDissmiss:(()->Void)?)->some View{
        return self.simpleToast(isPresented: isPresented, options: Toast.succOrFailOpt, onDismiss: onDissmiss){
            return Toast.getToastContent(title: title, state: state)
        }
    }
}

struct ToastView: View {
    @State var toast = false
    @State var saveSuccess = false
    @State var saveFailed = false
    @State var loginSuccess = false
    @State var loginFailed = false
    var body: some View {
        VStack{
            Button("SaveSuccess", action:{saveSuccess.toggle()})
            Button("SaveFailed",action: {saveFailed.toggle()})
            Button("LoginSuccess", action: {loginSuccess.toggle()})
        }
        .toast(isPresented: self.$saveSuccess, type: .saveFile, state: .success)
        .toast(isPresented: self.$saveFailed, type: .saveFile, state: .failed)
        .toast(isPresented: self.$loginSuccess, title: "Login Success", state: .success)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView()
    }
}
