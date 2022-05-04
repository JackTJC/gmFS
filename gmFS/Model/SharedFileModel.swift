//
//  SharedFileModel.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/30.
//

import Foundation

struct SharedFile:Codable{
    var fileID:Int64
    var fileName:String
    var key:Data
}

extension SharedFile:Identifiable{
    var id:Int64{
        return fileID
    }
}
