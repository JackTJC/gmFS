//
//  UserCacheModel.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/26.
//

import Foundation

/// 用户信息本地记录
struct UserInfoModel:Codable{
    var token:String
    var name:String
    var email:String
    var rootNode:Int64
}
