//
//  LoadingView.swift
//  gmFS
//
//  Created by jincaitian on 2022/5/1.
//

import SwiftUI
import ActivityIndicatorView

struct LoadingView: View {
    @Binding var show:Bool
    var body: some View {
        ActivityIndicatorView(isVisible: self.$show, type: .rotatingDots(count: 8))
            .frame(width: 70, height: 70)
            .foregroundColor(.blue)
    }
}

struct PreviewLoadingView:View{
    @State private var showing = true
    var body: some View{
        LoadingView(show: self.$showing)
    }
}

struct LoadingView_Previews: PreviewProvider {
    @State static private var show = true
    static var previews: some View {
        PreviewLoadingView()
    }
}
