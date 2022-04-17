//
//  File.swift
//  gmFS
//
//  Created by bytedance on 2022/4/9.
//

import Foundation


class NetworkService{
    private static var backendHost = "http://121.5.224.250:9000"
    private static var defaultHeader = ["Content-Type":"application/json"]
    func request(uri:String,method:String = "POST",body:Data,
                 header:[String:String] = NetworkService.defaultHeader,
                 success:@escaping ((Data) -> Void),
                 failure:@escaping ((Error)->Void)){
        let url = URL(string: NetworkService.backendHost+uri)!
        var req = URLRequest(url: url)
        req.httpBody=body
        req.httpMethod = method
        req.allHTTPHeaderFields=header
        let task = URLSession.shared.dataTask(with: req){data,resp,error in
            if let data = data{
                success(data)
            }else if let error = error {
                failure(error)
            }
        }
        task.resume()
    }
}
