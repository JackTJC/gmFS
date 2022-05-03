//
//  EncryptService.swift
//  gmFS
//
//  Created by jincaitian on 2022/5/2.
//

import Foundation
import CryptoKit

class EncryptService{
    static func aesEncrypt(identity:String,plainText:Data) throws -> Data {
        let key = getKey(identity: identity)
        let sealBoxData=try AES.GCM.seal(plainText, using: key).combined
        return sealBoxData!
    }
    static func aesDecrypt(identity:String,cipherText:Data) throws -> Data{
        let key = getKey(identity: identity)
        let sealedBox = try AES.GCM.SealedBox(combined: cipherText)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        return decryptedData
    }
    private static func getKey(identity:String) -> SymmetricKey{
        let dgst = SHA256.hash(data: identity.data(using: .utf8)!)
        let key = SymmetricKey(data: dgst)
        return key
    }
    
}
