//
//  SharedFileModel.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/30.
//

import Foundation

/// 发送给其他设备的文件
struct SharedFileModel:Codable{
    var fileID:Int64
    var fileName:String
    var key:Data
}

extension SharedFileModel:Identifiable{
    var id:Int64{
        return fileID
    }
}
