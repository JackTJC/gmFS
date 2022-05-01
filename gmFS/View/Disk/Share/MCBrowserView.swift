//
//  MCShareView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/20.
//

import SwiftUI
import MultipeerConnectivity

import MultipeerConnectivity
import SwiftUI

final class BrowserViewControllerRepresent:NSObject{
    private var didFinish:Binding<Bool>
    private var wasCanceled:Binding<Bool>
    var shareService:ShareService
    public init(didFinish:Binding<Bool>,wasCanceled:Binding<Bool>,shareService:ShareService) {
        self.didFinish=didFinish
        self.wasCanceled = wasCanceled
        self.shareService = shareService
    }
}
extension BrowserViewControllerRepresent:MCBrowserViewControllerDelegate{
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        self.didFinish.wrappedValue.toggle()
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        self.wasCanceled.wrappedValue.toggle()
    }
}

extension BrowserViewControllerRepresent:UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> MCBrowserViewController {
        let controler = MCBrowserViewController(serviceType: ShareService.serviceType, session: shareService.mcSession)
        controler.delegate=self
        return controler
    }
    
    func updateUIViewController(_ uiViewController: MCBrowserViewController, context: Context) {
    }
    
    typealias UIViewControllerType = MCBrowserViewController
    
}

struct MCBrowserView: View {
    @State private var didFinish = false
    @State private var wasCancel = false
    var body: some View {
        BrowserViewControllerRepresent(didFinish: self.$didFinish, wasCanceled: self.$wasCancel,shareService: ShareService())
    }
}

struct MCShareView_Previews: PreviewProvider {
    static var previews: some View {
        MCBrowserView()
    }
}
