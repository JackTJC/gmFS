//
//  Connect.swift
//  gmFS
//
//  Created by jincaitian on 2022/2/14.
//

import Foundation
import NetworkExtension

class WifiConnector{
    var ssid:String
    var passwd:String
    var isWEP:Bool = false
    init(_ ssid:String,_ passwd:String,_ isWEP:Bool){
        self.ssid=ssid
        self.passwd=passwd
        self.isWEP=isWEP
    }
    init(_ ssid:String,_ passwd:String){
        self.passwd=passwd
        self.ssid=ssid
    }
    
    func Connect()->Error?{
        let config = NEHotspotConfiguration(ssid: self.ssid, passphrase: self.passwd, isWEP: self.isWEP)
        var ret:Error?
        NEHotspotConfigurationManager.self.shared.apply(config){(error) in
            ret=error
        }
        return ret
    }
}
