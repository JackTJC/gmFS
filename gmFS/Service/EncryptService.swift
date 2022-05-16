//
//  EncryptService.swift
//  gmFS
//
//  Created by jincaitian on 2022/5/2.
//

import Foundation
import CryptoKit
import SwiftUI

class EncryptService{
    static var saltData = "gmFs-salt".data(using: .utf8)!
    /// 使用身份标识进行对称加密
    static func symEncWithId(identity:String,plainText:Data) throws -> Data {
        let key = getKey(identity: identity)
        let cipherText = try EncryptService.encryptWithSymKey(key: key, plainText: plainText)
        return cipherText
    }
    /// 使用身份标识进行对称解密
    static func symDecWithId(identity:String,cipherText:Data) throws -> Data{
        let key = getKey(identity: identity)
        let plainText = try EncryptService.decryptWithSymKey(key: key, cipherText: cipherText)
        return plainText
    }
    /// 使用对称密钥进行加密
    static func encryptWithSymKey(key:SymmetricKey,plainText:Data)throws->Data{
        let sealBoxData = try AES.GCM.seal(plainText, using: key).combined
        return sealBoxData!
    }
    /// 使用对称密钥进行解密
    static func decryptWithSymKey(key:SymmetricKey,cipherText:Data)throws->Data{
        let sealedBox = try AES.GCM.SealedBox(combined: cipherText)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        return decryptedData
    }
    /// 根据身份标识生成对称密钥
    private static func getKey(identity:String) -> SymmetricKey{
        let keyInit = sha256Pre32(s: identity)
        let key = SymmetricKey(data: keyInit)
        return key
    }
    
    /// 根据文件内容生成搜索关键词
    /// 仅限于文本文件
    static func extractKeyword(fileContent:Data) -> [String]{
        let contentStr = String(data: fileContent, encoding: .utf8)!
        let plainTextKeywords = contentStr.regexGetSub(pattern: "[a-zA-Z]+")
        let dgstKeywords = plainTextKeywords.map{ plainKeyword in
            return word2SHA256Dgst(keyword: plainKeyword)
        }
        return dgstKeywords
    }
    
    static func word2SHA256Dgst(keyword:String) -> String{
        let desc = SHA256.hash(data: keyword.data(using: .utf8)!).description
        return String(desc.split(separator: " ")[2]) // crypto原生的desc会生成形如 "SHA256 Digest: xxxx" 的字符串, 为了简便这里直接取最后面的部分
    }
    
    /// 获取字符串SHA256摘要的前32位
    static func sha256Pre32(s:String) -> Data{
        let dgst = SHA256.hash(data: s.data(using: .utf8)!)
        let hexStr = dgst.compactMap{String(format: "%02x", $0)}.joined()
        return hexStr.data(using: .utf8)!.subdata(in: 0..<32)
    }
}
