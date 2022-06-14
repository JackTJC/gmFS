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
    
    /// 标识自身设备
    private var peerID:MCPeerID!
    
    /// 会话建立后的session
    private var mcSession:MCSession!
    
    /// 广播器，广播自身给周围设备
    private var mcNearByAdv:MCNearbyServiceAdvertiser!
    /// 已收到文件列表，暂存收到的文件
    @Published var recvFiles:[SharedFileModel] = []
    
    var toastMsg = ""
    @Published var receiveFile = false
    
    /// 生成的密钥对
    private var privateKey = Curve25519.KeyAgreement.PrivateKey()
    
    /// 密钥协商是否完成
    private var keyHasAgree = false
    
    /// 协商得到的会话密钥
    private var symKey:SymmetricKey = SymmetricKey(size: .bits256)
    
    
    /// 构造函数
    override init(){
        peerID=MCPeerID(displayName: UIDevice.current.name)
        mcSession=MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        super.init()
        mcSession.delegate=self
    }
    
    /// 建立一个局域网会话并向周围设备广播自己
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
    
    
    /// 向已连接的设备发送文件
    func sendFile(sharedFile:SharedFileModel)throws{
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
            // 连接后立刻发送自身公钥
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
        if !keyHasAgree{// 如果协商没完成，按公钥解释
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
        }else{//否则按SharedFileModel解释
            do{
                let decData = try EncryptService.decryptWithSymKey(key: self.symKey, cipherText: data)
                AppManager.logger.info("revice file data from \(peerID.displayName)")
                let sharedFile = try JSONDecoder().decode(SharedFileModel.self, from: decData)
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
        invitationHandler(true,mcSession) // 传true为接受所有邀请
    }
}
