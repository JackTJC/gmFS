//
//  File.swift
//  gmFS
//
//  Created by bytedance on 2022/4/9.
//

import Foundation


class NetworkService:NSObject,URLSessionDelegate{
    let selfSignedHost = ["121.5.224.250"]
    private static var backendHost = "https://121.5.224.250:8888" // 服务端接口调用地址
    private static var defaultHeader = ["Content-Type":"application/json"]
    
    ///  向服务端发起HTTPS请求
    func request(uri:String,method:String = "POST",body:Data,
                 header:[String:String] = NetworkService.defaultHeader,
                 success:@escaping ((Data) -> Void),
                 failure:@escaping ((Error)->Void)){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config,delegate: self,delegateQueue: OperationQueue.main)
        let url = URL(string: NetworkService.backendHost+uri)!
        var req = URLRequest(url: url)
        req.httpBody=body
        req.httpMethod = method
        req.allHTTPHeaderFields=header
        let task = session.dataTask(with: req){data,resp,error in
            if let data = data{
                success(data)
            }else if let error = error {
                failure(error)
            }
        }
        task.resume()
    }
    //  参考自https://www.hangge.com/blog/cache/detail_991.html
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        switch challenge.protectionSpace.authenticationMethod{
        case NSURLAuthenticationMethodServerTrust:
            if self.selfSignedHost.contains(challenge.protectionSpace.host){
                let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                completionHandler(.useCredential,credential)
            }else{
                completionHandler(.cancelAuthenticationChallenge, nil);
            }
        case NSURLAuthenticationMethodClientCertificate:
            //获取客户端证书相关信息
            let identityAndTrust:IdentityAndTrust = self.extractIdentity()
            let urlCredential:URLCredential = URLCredential(
                identity: identityAndTrust.identityRef,
                certificates: identityAndTrust.certArray as? [AnyObject],
                persistence: URLCredential.Persistence.forSession)
            
            completionHandler(.useCredential, urlCredential)
        default:
            completionHandler(.cancelAuthenticationChallenge, nil);
        }
    }
    
    //获取客户端证书相关信息
    func extractIdentity() -> IdentityAndTrust {
        var identityAndTrust:IdentityAndTrust!
        var securityError:OSStatus = errSecSuccess
        
        let path: String = Bundle.main.path(forResource: "ca", ofType: "p12")!
        let PKCS12Data = NSData(contentsOfFile:path)!
        let key : NSString = kSecImportExportPassphrase as NSString
        let options : NSDictionary = [key : "!Tjc1962370203"] //客户端证书密码
        
        var items : CFArray?
        
        securityError = SecPKCS12Import(PKCS12Data, options, &items)
        
        if securityError == errSecSuccess {
            let certItems:CFArray = items!;
            let certItemsArray:Array = certItems as Array
            let dict:AnyObject? = certItemsArray.first;
            if let certEntry:Dictionary = dict as? Dictionary<String, AnyObject> {
                // grab the identity
                let identityPointer:AnyObject? = certEntry["identity"];
                let secIdentityRef:SecIdentity = identityPointer as! SecIdentity
                //                print("\(identityPointer)  :::: \(secIdentityRef)")
                // grab the trust
                let trustPointer:AnyObject? = certEntry["trust"]
                let trustRef:SecTrust = trustPointer as! SecTrust
                //                print("\(trustPointer)  :::: \(trustRef)")
                // grab the cert
                let chainPointer:AnyObject? = certEntry["chain"]
                identityAndTrust = IdentityAndTrust(identityRef: secIdentityRef,
                                                    trust: trustRef, certArray:  chainPointer!)
            }
        }
        return identityAndTrust;
    }
}


//定义一个结构体，存储认证相关信息
struct IdentityAndTrust {
    var identityRef:SecIdentity
    var trust:SecTrust
    var certArray:AnyObject
}
