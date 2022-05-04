//
//  EncryptService.swift
//  gmFS
//
//  Created by jincaitian on 2022/5/2.
//

import Foundation
import CryptoKit

class EncryptService{
    /// 使用身份标识进行aes加密
    static func aesEncrypt(identity:String,plainText:Data) throws -> Data {
        let key = getKey(identity: identity)
        let sealBoxData=try AES.GCM.seal(plainText, using: key).combined
        return sealBoxData!
    }
    /// 使用身份标识进行aes解密
    static func aesDecrypt(identity:String,cipherText:Data) throws -> Data{
        let key = getKey(identity: identity)
        let sealedBox = try AES.GCM.SealedBox(combined: cipherText)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        return decryptedData
    }
    /// 使用共享密钥进行aes加密
    static func encryptWithSharedSecret(sharedKey:SharedSecret,plainText:Data)throws->Data{
        let key = SymmetricKey(data: sharedKey)
        let sealBoxData = try AES.GCM.seal(plainText, using: key).combined
        return sealBoxData!
    }
    /// 使用共享密钥进行aes解密
    static func decryptWithSharedKey(sharedKey:SharedSecret,cipherText:Data)throws->Data{
        let key = SymmetricKey(data: sharedKey)
        let sealedBox = try AES.GCM.SealedBox(combined: cipherText)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        return decryptedData
    }
    /// 根据身份标识生成aes对称密钥
    private static func getKey(identity:String) -> SymmetricKey{
        let dgst = SHA256.hash(data: identity.data(using: .utf8)!)
        let key = SymmetricKey(data: dgst)
        return key
    }
    
}
