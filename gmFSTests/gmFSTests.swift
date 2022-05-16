//
//  gmFSTests.swift
//  gmFSTests
//
//  Created by jincaitian on 2022/2/14.
//

import XCTest
import Foundation
import CryptoKit
@testable import gmFS



class gmFSTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        NSLog("dir:%@",NSHomeDirectory())
        
    }
    
    // local cache test
    func testSet()throws{
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: "user_cache")
        userDefault.synchronize()
    }
    
    func testGet()throws{
        let token = UserDefaults.standard.object(forKey: "user_cache")
        print(token!)
    }
    
    // crypto kit test
    func testSymmertryKey()throws{
        let name = "tianjincai"
        let email = "tianjincai@hotmail.com"
        let concat = name+email
        let d = concat.data(using: .utf8)!
        let key256 = SymmetricKey(data: d)
        let concat1="tianjincaitianjincai@hotmail.com"
        let d1 = concat1.data(using: .utf8)!
        let key2561=SymmetricKey(data: d1)
        XCTAssert(key256==key2561)
    }
    
    // test key size
    func testKeySize()throws{
        let s = "tianjincai"
        let hash = SHA256.hash(data: s.data(using: .utf8)!)
        let key = SymmetricKey(data: hash)
        print(hash)
        print(key.bitCount)
    }
    
    // chacha test
    func testCha()throws{
        let key = getKey()
        let s = "this is my data to be encrypted"
        let data = s.data(using: .utf8)!
        let sealBoxData = try! ChaChaPoly.seal(data, using: key).combined
        let sealedBox = try! ChaChaPoly.SealedBox(combined: sealBoxData)
        let decryptedData = try! ChaChaPoly.open(sealedBox, using: key)
        let decStr = String(data: decryptedData, encoding: .utf8)
        XCTAssert(decStr==s)
    }
    
    func testAes()throws{
        let key = getKey()
        let s = "this is my data used in aes test"
        let data = s.data(using: .utf8)!
        let sealBoxData=try! AES.GCM.seal(data, using: key).combined
        let sealedBox = try! AES.GCM.SealedBox(combined: sealBoxData!)
        let decryptedData = try! AES.GCM.open(sealedBox, using: key)
        let decStr = String(data: decryptedData, encoding: .utf8)
        XCTAssert(decStr == s)
    }
    // test share key agreement
    func testEccKey()throws{
        var start:CFAbsoluteTime
        var end:CFAbsoluteTime
        start=CFAbsoluteTimeGetCurrent()
        let ask = Curve25519.KeyAgreement.PrivateKey()
        let bsk = Curve25519.KeyAgreement.PrivateKey()
        end=CFAbsoluteTimeGetCurrent()
        NSLog("gen private key:%10.2f us",   (end-start)*1000000)
        let apk = ask.publicKey.rawRepresentation
        let bpk = bsk.publicKey.rawRepresentation
        start = CFAbsoluteTimeGetCurrent()
        let a_get_bpk = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: bpk)
        let b_get_apk = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: apk)
        let a_share_key = try! ask.sharedSecretFromKeyAgreement(with: a_get_bpk)
        let b_share_key = try! bsk.sharedSecretFromKeyAgreement(with: b_get_apk)
        end = CFAbsoluteTimeGetCurrent()
        NSLog("share secret gen:%10.2f us",   (end-start)*1000000)
        XCTAssert(a_share_key==b_share_key)
        let saltProtocol = "salt".data(using: .utf8)!
        start = CFAbsoluteTimeGetCurrent()
        let a_sym_key = a_share_key.hkdfDerivedSymmetricKey(using: SHA256.self, salt: saltProtocol, sharedInfo: Data(), outputByteCount: 256)
        let b_sym_key = b_share_key.hkdfDerivedSymmetricKey(using: SHA256.self, salt: saltProtocol, sharedInfo: Data(), outputByteCount: 256)
        end  = CFAbsoluteTimeGetCurrent()
        NSLog("sym key gen:%10.2f us",   (end-start)*1000000)
        XCTAssert(a_sym_key==b_sym_key)
        print(a_sym_key.bitCount)
        print(b_sym_key.bitCount)
    }
    
    func testEnc2()throws{
        let s = "this is test data"
        let encData1 = try EncryptService.symEncWithId(identity: "tianjincai", plainText: s.data(using: .utf8)!)
        let encData2 = try EncryptService.symEncWithId(identity: "tianjincai", plainText: s.data(using: .utf8)!)
        XCTAssert(encData1==encData2)
        print(encData1.base64EncodedString())
        print(encData2.base64EncodedString())
    }
    
    func testSplit()throws{
        let s = "this is test data"
        print(s.split(separator:" "))
    }
    
    func testUUID()throws{
        let uid = UUID()
        print(uid.uuidString)
        let dgst = SHA256.hash(data: uid.uuidString.data(using: .utf8)!)
        let key = SymmetricKey(data: dgst)
        print(key.bitCount)
    }
    
    func testRegex()throws{
        let s = "this is my test for regex, hello world! just one TEST"
        print(s.regexGetSub(pattern: "[a-zA-Z]+"))
    }
    
    func testExtract()throws{
        let s = "this is my test for regex, hello world! just one TEST"
        let res1 = EncryptService.extractKeyword(fileContent: s.data(using: .utf8)!)
        let res2 = EncryptService.extractKeyword(fileContent: s.data(using: .utf8)!)
        
        print(res1)
        print(res2)
    }
    
    func getKey()->SymmetricKey{
        let s = "tianjincai"
        let  dgst = SHA256.hash(data: s.data(using: .utf8)!)
        let key = SymmetricKey(data: dgst)
        return key
    }
    
    func testSearchFile()throws{
        let s = "search"
        let sw = EncryptService.word2SHA256Dgst(keyword: s)
        BackendService().SearchFile(keyword: sw){resp in
            print(resp)
        }failure: { err in
            print(err)
        }
        sleep(1000)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWifiConnector()throws{
        
    }
    
    func testCost()throws{
        let key = UUID().uuidString
        for i in 1...30{
            let data = fileGen.getXmFile(x: 5*i)
            let startTime = CFAbsoluteTimeGetCurrent()
            let encData = try EncryptService.symEncWithId(identity: key, plainText: data)
            let endTime = CFAbsoluteTimeGetCurrent()
//            print("\(5*i)m file, cost \((endTime-startTime)*1000000) us to enc, origin size:\(data.count), enced size:\(encData.count)")
            NSLog("%3dm file, cost %10.2f us, origin size:%10d, enc size:%10d", 5*i,(endTime-startTime)*1000000,data.count,encData.count)
        }
    }
    
    func getXmFile(x:Int)->Data{
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "1m", ofType: "txt")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        var ret = Data()
        for _ in 1...x{
            ret.append(data)
        }
        return ret
    }
    
    func testKeyData()throws{
        let key = SymmetricKey(size: .bits256)
        print(key)
    }
    
    func testEncWithIV()throws{
        // iv 生成
        let iv = try AES.GCM.Nonce(data: "123412341234".data(using: .utf8)!)
        // key生成
        let dgst = SHA256.hash(data: "helloworld".data(using: .utf8)!)
        let key = SymmetricKey(data: dgst)
        // 明文data
        let data = "helloworld".data(using: .utf8)!
        // tag生成
        let tag = "1234123412341234".data(using: .utf8)!
        let cipherText = try AES.GCM.seal(data, using: key, nonce: iv).ciphertext
        let encData = try AES.GCM.SealedBox(nonce: iv, ciphertext: cipherText, tag: tag).combined
        print(encData?.base64EncodedString())
        print(encData?.count)
    }
    
    func testDec()throws{
        let encData = Data(base64Encoded: "pvwAde+HirqFd441vqA4Gsps35/DYlHU2+cP4fMLxcifQAng0H0=")!
        let keyData="helloworld".data(using: .utf8)!
        let desc=SHA256.hash(data: keyData).description
        let dgst = String(desc.split(separator: " ")[2]).data(using: .utf8)!
        let pre32 = dgst.subdata(in: 0..<32)
        let key = SymmetricKey(data: pre32)
        let decData = try EncryptService.decryptWithSymKey(key: key, cipherText: encData)
        print(decData.count)
        print(String(data: decData, encoding: .utf8))
    }
    
    func testDgst()throws{
        let s = "helloworld"
        let dgst = SHA256.hash(data: s.data(using: .utf8)!)
        let desc = dgst.compactMap{String(format: "%02x", $0)}.joined()
        print(desc.lengthOfBytes(using: .utf8))
        let ss = String(dgst.description.split(separator: " ")[2])
        XCTAssert(ss == desc)
    }
    
    func test32Enc()throws{
        let data = "helloworld".data(using: .utf8)!
        let dgstDesc = SHA256.hash(data: data).description
        let hex = String(dgstDesc.split(separator: " ")[2]).data(using: .utf8)!
        let pre32=hex.subdata(in: 0..<32)
        let key = SymmetricKey(data: pre32)
        let encData = try EncryptService.encryptWithSymKey(key: key, plainText: data)
        print(encData.base64EncodedString())
    }
    
   
}
class fileGen{
    static func getXmFile(x:Int)->Data{
        var ret = Data()
        for _ in 1...x{
            ret.append(fileSize1M)
        }
        return ret
    }
    static var fileSize1M = get1MDataRandom()
    private  static func get1MDataRandom()->Data{
        var ret = Data()
        while ret.count<1024*1024{
            ret.append(UUID().uuidString.data(using: .utf8)!)
        }
        return ret
     }
}
