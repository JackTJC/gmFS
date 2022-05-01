//
//  MultiPeer.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/28.
//

import Foundation
import MultipeerConnectivity

extension MCPeerID:Identifiable{
    public var id:String{
        return displayName
    }
}
