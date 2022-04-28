//
//  ShareService.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/22.
//

import Foundation
import MultipeerConnectivity

final class ShareService:NSObject,ObservableObject{
    static var serviceType = "gmFS-ftf"
    let peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession:MCSession
    var mcAdvAsst:MCAdvertiserAssistant? = nil
    var mcNearByAdv:MCNearbyServiceAdvertiser? = nil
    
    override init(){
        mcSession=MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        super.init()
        mcSession.delegate=self
    }
    
    func startHost() {
        mcAdvAsst = MCAdvertiserAssistant(serviceType: ShareService.serviceType, discoveryInfo: nil, session: mcSession)
        mcAdvAsst?.start()
    }
    
    func startHostNeayBy(){
        mcNearByAdv = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: ShareService.serviceType)
        mcNearByAdv?.startAdvertisingPeer()
    }
}

extension ShareService:MCSessionDelegate{
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            AppManager.logger.info("\(peerID.displayName) change to not connected")
        case .connecting:
            AppManager.logger.info("\(peerID.displayName) change to connecting")
        case .connected:
            AppManager.logger.info("\(peerID.displayName) change to connected")
        @unknown default:
            AppManager.logger.info("\(peerID.displayName) unknown state")
        }
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
    
    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        print(certificate)
        AppManager.logger.info("receive certificate from \(peerID.displayName)")
        certificateHandler(true)
    }
}
