//
//  ShareView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/20.
//

import Foundation
import MultipeerConnectivity
import SwiftUI

final class ShareView:NSObject{
    private var didFinish:Binding<Bool>
    private var wasCanceled:Binding<Bool>
    var shareService:ShareService
    public init(didFinish:Binding<Bool>,wasCanceled:Binding<Bool>,shareService:ShareService) {
        self.didFinish=didFinish
        self.wasCanceled = wasCanceled
        self.shareService = shareService
    }
}
extension ShareView:MCBrowserViewControllerDelegate{
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        self.didFinish.wrappedValue.toggle()
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        self.wasCanceled.wrappedValue.toggle()
    }
}

extension ShareView:UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> MCBrowserViewController {
        //let shareService = ShareService()
        let controler = MCBrowserViewController(serviceType: ShareService.serviceType, session: shareService.mcSession)
        controler.delegate=self
        return controler
    }
    
    func updateUIViewController(_ uiViewController: MCBrowserViewController, context: Context) {
    }
    
    typealias UIViewControllerType = MCBrowserViewController
    
}
