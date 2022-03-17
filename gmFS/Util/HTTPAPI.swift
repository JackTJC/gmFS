//
//  HTTPAPI.swift
//  gmFS
//
//  Created by bytedance on 2022/3/17.
//

import Foundation
import UIKit


class HTTPAPI{
    // 域名/IP:PORT的形式
    let host:String
    // 协议类型
    var protocolType:ProtocolType
    // 资源定位目录
    var uri:String
    // header
    var header:[String:String]
    // http方法
    var method:Method
    
    enum ProtocolType:String{
        case HTTP = "https://"
        case HTTPS = "http://"
    }
    enum Method:String{
        case GET="GET"
        case POST="POST"
        case PUT="PUT"
    }
    init(_ host:String){
        self.host=host
        self.protocolType = .HTTP
        self.uri=""
        self.header = [:]
        self.method = .GET
    }
    // 指定协议类型
    func withProtocol(_ protocolType:ProtocolType)->HTTPAPI{
        self.protocolType=protocolType
        return self
    }
    func withMethod(_ method:Method)->HTTPAPI{
        self.method=method
        return self
    }
    // 指定资源定位地址
    func withUri(_ uri:String)->HTTPAPI{
        self.uri=uri
        return self
    }
    // 全量指定http头
    func withHeader(_ h:[String:String])->HTTPAPI{
        self.header=h
        return self
    }
    // 单个指定http头
    func addHeader(_ k:String,_ v:String)->HTTPAPI{
        self.header[k]=v
        return self
    }
    // 发出请求
    func doRequest(){
        // url拼接
        let url = URL(string: self.protocolType.rawValue+self.host+self.uri)!
        var request = URLRequest(url: url)
        // header，method指定
        request.allHTTPHeaderFields=self.header
        request.httpMethod=self.method.rawValue
        // 构建task
        let task = URLSession.shared.dataTask(with: request){ data,response,error in
            if let data = data {
                print(data)
            }else if let error = error {
                print(error)
            }
        }
        // 执行
        task.resume()
    }
    
}
