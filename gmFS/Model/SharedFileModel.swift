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
}

extension SharedFile:Identifiable{
    var id:Int64{
        return fileID
    }
}
