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
        let ask = Curve25519.KeyAgreement.PrivateKey()
        let apk = ask.publicKey.rawRepresentation
        let bsk = Curve25519.KeyAgreement.PrivateKey()
        let bpk = bsk.publicKey.rawRepresentation
        let a_get_bpk = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: bpk)
        let b_get_apk = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: apk)
        let a_share_key = try! ask.sharedSecretFromKeyAgreement(with: a_get_bpk)
        let b_share_key = try! bsk.sharedSecretFromKeyAgreement(with: b_get_apk)
        XCTAssert(a_share_key==b_share_key)
        let key = SymmetricKey(data: a_share_key)
        print(key.bitCount)
    }
    
    func testEnc2()throws{
        let s = "this is test data"
        let encData1 = try EncryptService.aesEncrypt(identity: "tianjincai", plainText: s.data(using: .utf8)!)
        let encData2 = try EncryptService.aesEncrypt(identity: "tianjincai", plainText: s.data(using: .utf8)!)
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
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWifiConnector()throws{
        
    }
}
