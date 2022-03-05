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
        <#code#>
    }
    
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        <#code#>
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        <#code#>
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        <#code#>
    }
    
}

extension ShareService:MCNearbyServiceAdvertiserDelegate{
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        <#code#>
    }
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer error:\(error)")
    }
    
}

extension ShareService:MCNearbyServiceBrowserDelegate{
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        <#code#>
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer:\(peerID.displayName)")
    }
}
