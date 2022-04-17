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


class BackendService{
    private class BackendUri{
        static var userLogin = "/user/login"
        static var userRegister  = "/user/register"
        static var fileUplaod = "/file/upload"
        static var fileDownload = "/file/download"
    }
    func UserLogin(name:String,passwd:String,
                   success:@escaping (UserLoginResponse)->Void,
                   failure:@escaping (Error)->Void){
        var req = UserLoginRequest()
        req.userName = name
        req.password = passwd
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
    
    func UploadFile(fileName:String,content:Data,
                    success:@escaping (UploadFileReponse)->Void,
                    failure:@escaping (Error)->Void){
        var req = UploadFileRequest()
        req.fileName=fileName
        req.content=content
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
    
}
