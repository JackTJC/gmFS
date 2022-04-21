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
    static private var serviceType = "gmFS-ftf"
    let peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession:MCSession
    
    override init(){
        mcSession=MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        super.init()
        mcSession.delegate=self
    }
}


extension ShareView:MCSessionDelegate{
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        AppManager.logger.info("\(peerID.displayName) change to \(state.rawValue)")
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        AppManager.logger.info("revice data:\(data) from \(peerID.displayName)")
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        AppManager.logger.info("receive stream with name:\(streamName) from \(peerID.displayName)")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        AppManager.logger.info("receive resource with name:\(resourceName) from \(peerID.displayName)")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        AppManager.logger.info("finish receive from \(peerID.displayName)")
    }
}

extension ShareView:MCBrowserViewControllerDelegate{
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    }
}

extension ShareView:UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> MCBrowserViewController {
        let shareView = ShareView()
        let controler = MCBrowserViewController(serviceType: ShareView.serviceType, session: shareView.mcSession)
        controler.delegate=shareView
        return controler
    }
    
    func updateUIViewController(_ uiViewController: MCBrowserViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = MCBrowserViewController
    
}
