//
//  TimeUtil.swift
//  gmFS
//
//  Created by bytedance on 2022/3/27.
//

import Foundation

typealias UnixTimestamp = Int64

extension Date {
    /// Date to Unix timestamp.
    var unixTimestamp: UnixTimestamp {
        return UnixTimestamp(self.timeIntervalSince1970 ) // millisecond precision
    }
}

extension UnixTimestamp {
    /// Unix timestamp to date.
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(self )) // must take a millisecond-precise Unix timestamp
    }
}

let unixTimestamp = Date().unixTimestamp
let date = unixTimestamp.date
