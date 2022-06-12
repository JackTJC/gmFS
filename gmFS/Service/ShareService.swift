//
//  ShareService.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/22.
//

import Foundation
import MultipeerConnectivity
import SwiftUI
import CryptoKit

final class ShareService:NSObject,ObservableObject{
    static var serviceType = "service"
    private var peerID:MCPeerID!
    private var mcSession:MCSession!
    private var mcNearByAdv:MCNearbyServiceAdvertiser!
    @Published var recvFiles:[SharedFile] = []
    var toastMsg = ""
    @Published var receiveFile = false
    private var privateKey = Curve25519.KeyAgreement.PrivateKey()
    private var keyHasAgree = false// 密钥协商是否完成
    private var symKey:SymmetricKey = SymmetricKey(size: .bits256)
    
    
    override init(){
        peerID=MCPeerID(displayName: UIDevice.current.name)
        mcSession=MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        super.init()
        mcSession.delegate=self
    }
    
    func startHostNeayBy(){
        self.mcNearByAdv = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: ShareService.serviceType)
        self.mcNearByAdv.delegate=self
        self.mcNearByAdv.startAdvertisingPeer()
    }
    
    func getSession()->MCSession{
        return self.mcSession
    }
    
    func getConnectedPeerCnt()->Int{
        return self.mcSession.connectedPeers.count
    }
    
    func sendFile(sharedFile:SharedFile)throws{
        let encodedData = try JSONEncoder().encode(sharedFile)
        let encData = try EncryptService.encryptWithSymKey(key: self.symKey, plainText: encodedData)
        try self.mcSession.send(encData, toPeers: mcSession.connectedPeers, with: .reliable)
    }
}

extension ShareService:MCSessionDelegate{
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            keyHasAgree = false
            AppManager.logger.info("\(peerID.displayName) change to not connected")
        case .connecting:
            AppManager.logger.info("\(peerID.displayName) change to connecting")
        case .connected:
            AppManager.logger.info("\(peerID.displayName) change to connected")
            do{
                try session.send(privateKey.publicKey.rawRepresentation, toPeers: [peerID], with: .reliable)
            }catch{
                AppManager.logger.error("send public key error")
            }
        @unknown default:
            AppManager.logger.info("\(peerID.displayName) unknown state")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if !keyHasAgree{
            do{
                AppManager.logger.info("receivce publick key from \(peerID.displayName)")
                let peerPk = try Curve25519.KeyAgreement.PublicKey(rawRepresentation: data)
                let shareKey = try privateKey.sharedSecretFromKeyAgreement(with: peerPk)
                self.symKey = shareKey.hkdfDerivedSymmetricKey(using: SHA256.self, salt: EncryptService.saltData, sharedInfo: Data(), outputByteCount: 32)
                AppManager.logger.info("handling success")
                self.keyHasAgree=true
            }catch{
                AppManager.logger.error("handle publick key from \(peerID.displayName) error")
            }
        }else{
            do{
                let decData = try EncryptService.decryptWithSymKey(key: self.symKey, cipherText: data)
                AppManager.logger.info("revice file data from \(peerID.displayName)")
                let sharedFile = try JSONDecoder().decode(SharedFile.self, from: decData)
                self.recvFiles.append(sharedFile)
                self.receiveFile.toggle()
                self.toastMsg="receive \(sharedFile.fileName) from \(peerID.displayName)"
            }catch{
                AppManager.logger.error("handle file data error")
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        AppManager.logger.debug("receive stream with name:\(streamName) from \(peerID.displayName)")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        AppManager.logger.debug("receive resource with name:\(resourceName) from \(peerID.displayName)")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        AppManager.logger.debug("finish receive from \(peerID.displayName)")
    }
}

extension ShareService:MCNearbyServiceAdvertiserDelegate{
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        AppManager.logger.info("receive invitation from \(peerID.displayName)")
        invitationHandler(true,mcSession)
    }
}
