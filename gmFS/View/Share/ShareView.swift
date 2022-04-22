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
    
}
extension ShareView:MCBrowserViewControllerDelegate{
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    }
}

extension ShareView:UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> MCBrowserViewController {
        let shareService = ShareService()
        let controler = MCBrowserViewController(serviceType: ShareService.serviceType, session: shareService.mcSession)
        controler.delegate=self
        return controler
    }
    
    func updateUIViewController(_ uiViewController: MCBrowserViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = MCBrowserViewController
    
}
