//
//  ShareService.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/22.
//

import Foundation
import MultipeerConnectivity
import SwiftUI

final class ShareService:NSObject,ObservableObject{
    static var serviceType = "service"
    private var peerID:MCPeerID!
    var mcSession:MCSession!
    private var mcNearByAdv:MCNearbyServiceAdvertiser!
    var sharedFileList:[SharedFile] = []
    var toastMsg = ""
    @Published var receiveFile = false
    
    override init(){
        peerID=MCPeerID(displayName: UIDevice.current.name)
        mcSession=MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        super.init()
        mcSession.delegate=self
    }
    
    func startHostNeayBy(){
        mcNearByAdv = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: ShareService.serviceType)
        mcNearByAdv.delegate=self
        mcNearByAdv.startAdvertisingPeer()
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
        AppManager.logger.info("revice data from \(peerID.displayName)")
        let sharedFile = try! JSONDecoder().decode(SharedFile.self, from: data)
        sharedFileList.append(sharedFile)
        receiveFile.toggle()
        toastMsg="receive \(sharedFile.fileName) from \(peerID.displayName)"
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

extension ShareService:MCNearbyServiceAdvertiserDelegate{
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        AppManager.logger.info("receive invitation from \(peerID.displayName)")
        invitationHandler(true,mcSession)
    }
}
