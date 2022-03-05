//
//  ShareService.swift
//  gmFS
//
//  Created by bytedance on 2022/3/5.
//

import Foundation
import MultipeerConnectivity

protocol ShareServiceDelegate{
    
}


class ShareService:NSObject{
   private let serviceType = "gmFS-ftf"
    private let  myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let serviceAdvertiser:MCNearbyServiceAdvertiser
    private let serviceBrowser:MCNearbyServiceBrowser
    var delegate:ShareServiceDelegate?
    lazy var session:MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate=self
        return session
    }()
    
    override init(){
        self.serviceAdvertiser=MCNearbyServiceAdvertiser(peer: self.myPeerId, discoveryInfo: nil, serviceType: self.serviceType)
        self.serviceBrowser=MCNearbyServiceBrowser(peer: self.myPeerId, serviceType: self.serviceType)
        super.init()
        self.serviceAdvertiser.delegate=self
        self.serviceBrowser.delegate=self
        self.serviceAdvertiser.startAdvertisingPeer()
        self.serviceBrowser.startBrowsingForPeers()
    }
    deinit{
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
}

extension ShareService:MCSessionDelegate{
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        NSLog("%@", "receive data:\(data) from \(peerID)")
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "revice stream: \(stream) with stream name: \(streamName) from \(peerID)")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        NSLog("%@", "receive resource with name:\(resourceName), progress:\(progress) from peerID:\(peerID)")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        NSLog("%@", "receive resource with name:\(resourceName) from \(peerID), local url: \(localURL), error: \(error)")
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        NSLog("%@", "from \(peerID), didChange: \(state)")
    }
    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        NSLog("%@", "receive certificate from \(peerID), certificate:\(certificate)")
    }
}

extension ShareService:MCNearbyServiceAdvertiserDelegate{
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        NSLog("%@","receive invite from: \(peerID)")
        invitationHandler(true,self.session)
    }
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer error:\(error)")
    }
    
}

extension ShareService:MCNearbyServiceBrowserDelegate{
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        NSLog("%@", "found peer id:\(peerID)")
        NSLog("%@", "invite peer id:\(peerID)")
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer:\(peerID)")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        NSLog("%@", "disNotStartBrowsingForPeers error\(error)")
    }
}
