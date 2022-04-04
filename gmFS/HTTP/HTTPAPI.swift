//
//  HTTPAPI.swift
//  gmFS
//
//  Created by bytedance on 2022/3/17.
//

import Foundation
import UIKit


class HTTPAPI{
    private static var host = "http://121.5.224.250:9000"

    // 资源定位目录
    private var uri:String = "/ping"
    // header
    private var header:[String:String] = ["Content-Type":"application/json"]
    // http方法
    private var method:Method = .POST
    // body数据
    private var body:Data? = nil
    
    enum Method:String{
        case GET="GET"
        case POST="POST"
        case PUT="PUT"
    }
    init(){
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
    func withBody(_ body:Data) -> HTTPAPI{
        self.body=body
        return self
    }
    // 发出请求
    func doRequest(){
        // url拼接
        let url = URL(string: HTTPAPI.host+self.uri)!
        var request = URLRequest(url: url)
        // header，method指定
        request.allHTTPHeaderFields=self.header
        request.httpMethod=self.method.rawValue
        request.httpBody=self.body
        print(request)
        // 构建task
        let task = URLSession.shared.dataTask(with: request){ data,response,error in
            if let data = data {
                print(response!)
                print(String(data: data, encoding: .utf8))
            }else if let error = error {
                print(error)
                fatalError()
            }
        }
        // 执行
        task.resume()
    }
    
}
