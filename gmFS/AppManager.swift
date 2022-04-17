//
//  AppManager.swift
//  gmFS
//
//  Created by bytedance on 2022/4/14.
//

import Foundation
import os

struct AppManager{
    static var logger = Logger()
    static func isLogined() -> Bool{
        return UserDefaults.standard.string(forKey: "token") != nil
    }
}
