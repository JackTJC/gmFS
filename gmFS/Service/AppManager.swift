//
//  AppManager.swift
//  gmFS
//
//  Created by bytedance on 2022/4/14.
//

import Foundation
import os

struct UserInfoModel:Codable{
    var token:String
    var name:String
    var email:String
    var rootNode:Int64
}

struct AppManager{
    static private var userCacheKey = "user_cache"
    static var logger = Logger()
    static private var userDefaults = UserDefaults.standard
    static private var userInfoDefault = UserInfoModel(token: "88a12f42-b45b-47d0-bd7b-626509dae938", name: "default name", email: "default@email.com", rootNode: 0)
    
    
    static func isLogined() -> Bool{
        return userDefaults.object(forKey: userCacheKey) != nil
    }
    
    static func setUserCache(_ userInfo:UserInfo,_ token:String){
        let userInfoModel = UserInfoModel(token: token, name: userInfo.userName, email: userInfo.email, rootNode: userInfo.rootID)
        userDefaults.set(try? PropertyListEncoder().encode(userInfoModel), forKey: userCacheKey)
    }
    
    static func getUserCache() -> UserInfoModel{
#if DEBUG
        userInfoDefault = UserInfoModel(token: "90ce22fc-d893-4a51-83f0-09c7881907aa", name: "default name", email: "default@email.com", rootNode:1517026803300962304 )
#endif
        if let data = userDefaults.value(forKey: userCacheKey) as? Data {
            let userCache = try? PropertyListDecoder().decode(UserInfoModel.self, from: data)
            if let userInfo = userCache{
                return userInfo
            }else{
                return userInfoDefault
            }
        } else {
            return userInfoDefault
        }
    }
    
    static func delUserCache(){
        userDefaults.removeObject(forKey: userCacheKey)
    }
}
