//
//  MCShareView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/20.
//

import SwiftUI
import MultipeerConnectivity

struct MCShareView: View {
    @State private var didFinish = false
    @State private var wasCancel = false
    var body: some View {
        ShareView(didFinish: self.$didFinish, wasCanceled: self.$wasCancel,shareService: ShareService())
    }
}

struct MCShareView_Previews: PreviewProvider {
    static var previews: some View {
        MCShareView()
    }
}
