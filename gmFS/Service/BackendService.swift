//
//  BackendService.swift
//  gmFS
//
//  Created by bytedance on 2022/4/9.
//

import Foundation
import UIKit
import SwiftProtobuf
import OSLog
import SwiftUI


class BackendService{
    private class BackendUri{
        static var ping = "/ping"
        static var userLogin = "/user/login"
        static var userRegister  = "/user/register"
        static var fileUplaod = "/file/upload"
        static var getNode = "/node/get"
        static var createDir = "/dir/create"
        static var registerFile = "/file/register"
    }
    func Ping(name:String,
              success:@escaping (PingResponse)->Void,
              failure:@escaping(Error)->Void){
        var req = PingRequest()
        req.name=name
        let userCache = AppManager.getUserCache()
        var baseReq = BaseReq()
        baseReq.token = userCache.token
        req.baseReq = baseReq
        let data = try! req.jsonUTF8Data()
        NetworkService().request(uri: BackendUri.ping, body: data){data in
            do{
                let resp = try PingResponse.init(jsonUTF8Data: data)
                success(resp)
            }catch is JSONDecodingError{
                AppManager.logger.error("ping json decode error")
            }catch{
                AppManager.logger.error("ping unknown error")
            }
        }failure: { err in
            failure(err)
        }
    }
    func UserLogin(name:String,passwd:String,
                   success:@escaping (UserLoginResponse)->Void,
                   failure:@escaping (Error)->Void){
        var req = UserLoginRequest()
        req.userName = name
        req.password = passwd
        let userCache = AppManager.getUserCache()
        var baseReq = BaseReq()
        baseReq.token = userCache.token
        req.baseReq = baseReq
        let data = try! req.jsonUTF8Data()
        NetworkService().request(uri: BackendUri.userLogin, body: data){data in
            do{
                let resp = try UserLoginResponse.init(jsonUTF8Data: data)
                success(resp)
            }catch is JSONDecodingError{
                AppManager.logger.error("user login json decode error")
            }catch{
                AppManager.logger.error("user login get unknown error")
            }
        }failure: { error in
            failure(error)
        }
    }
    func UserRegister(name:String,passwd:String,email:String,
                      success:@escaping (UserRegisterResponse)->Void,
                      failure:@escaping (Error)->Void){
        var req = UserRegisterRequest()
        req.userName = name
        req.password = passwd
        req.email = email
        let userCache = AppManager.getUserCache()
        var baseReq = BaseReq()
        baseReq.token = userCache.token
        req.baseReq = baseReq
        let data = try! req.jsonUTF8Data()
        NetworkService().request(uri: BackendUri.userRegister, body: data){data in
            do{
                let resp = try UserRegisterResponse.init(jsonUTF8Data: data)
                success(resp)
            }catch is JSONDecodingError{
                AppManager.logger.error("user register json decode error")
            }catch{
                AppManager.logger.error("user register get unknown error")
            }
        }failure: { error in
            failure(error)
        }
    }
    
    func UploadFile(fileName:String,content:Data,parentID:Int64,key:Data,
                    success:@escaping (UploadFileReponse)->Void,
                    failure:@escaping (Error)->Void){
        var req = UploadFileRequest()
        req.fileName=fileName
        req.content=content
        req.parentID=parentID
        req.secretKey=key
        let userCache = AppManager.getUserCache()
        var baseReq = BaseReq()
        baseReq.token = userCache.token
        req.baseReq = baseReq
        let data = try! req.jsonUTF8Data()
        NetworkService().request(uri: BackendUri.fileUplaod, body: data){data in
            do {
                let resp = try UploadFileReponse.init(jsonUTF8Data: data)
                success(resp)
            }catch is JSONDecodingError{
                AppManager.logger.error("upload file json decode error")
            }catch{
                AppManager.logger.error("upload file get unknow error")
            }
        }failure: { Error in
            failure(Error)
        }
    }
    
    func GetNode(nodeID:Int64,
                 success:@escaping (GetNodeResponse) -> Void,
                 failure:@escaping(Error)->Void){
        var req = GetNodeRequest()
        req.nodeID = nodeID
        let userCache = AppManager.getUserCache()
        var baseReq = BaseReq()
        baseReq.token = userCache.token
        req.baseReq = baseReq
        let data = try! req.jsonUTF8Data()
        NetworkService().request(uri: BackendUri.getNode, body: data){ respData in
            do {
                let resp = try GetNodeResponse.init(jsonUTF8Data: respData)
                success(resp)
            }catch is JSONDecodingError{
                AppManager.logger.error("get node json decode error")
            }catch{
                AppManager.logger.error("get node get unknown error")
            }
        }failure: { Error in
            failure(Error)
        }
    }
    
    func CreateDir(dirName:String,parentID:Int64,
                   success:@escaping (CreateDirResponse) -> Void,
                   failure:@escaping (Error) -> Void){
        var req = CreateDirRequest()
        req.dirName=dirName
        req.parentID=parentID
        let userCache = AppManager.getUserCache()
        var baseReq = BaseReq()
        baseReq.token = userCache.token
        req.baseReq = baseReq
        let data = try! req.jsonUTF8Data()
        NetworkService().request(uri: BackendUri.createDir, body: data){respData in
            do {
                let resp = try CreateDirResponse.init(jsonUTF8Data: respData)
                success(resp)
            }catch is JSONDecodingError{
                AppManager.logger.error("create dir json decode error")
            }catch{
                AppManager.logger.error("create dir get unknown error")
            }
        }failure: { Error in
            failure(Error)
        }
    }
    
    func RegisterFile(fileID:Int64,dirID:Int64,key:Data,
                      success:@escaping (RegisterFileResponse)->Void,
                      failure:@escaping (Error) -> Void){
        var req = RegisterFileRequest()
        req.fileID=fileID
        req.dirID=dirID
        req.secretKey=key
        let userCache = AppManager.getUserCache()
        var baseReq = BaseReq()
        baseReq.token = userCache.token
        req.baseReq = baseReq
        let data = try! req.jsonUTF8Data()
        NetworkService().request(uri: BackendUri.registerFile, body: data){respData in
            do{
                let resp = try RegisterFileResponse.init(jsonUTF8Data: respData)
                success(resp)
            }catch is JSONDecodingError{
                AppManager.logger.error("register file json decode error")
            }catch{
                AppManager.logger.error("register file get unknown error")
            }
        }failure: { Error in
           failure(Error)
        }
    }
}
