//
//  StringUtil.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/14.
//

import Foundation

extension String {
    /// 校验邮箱是否合法
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    /// 帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)
    var isValidUserName:Bool{
        NSPredicate(format: "SELF MATCHES %@","^[a-zA-Z][a-zA-Z0-9_]{4,15}$").evaluate(with: self)
    }
    /// 密码(以字母开头，长度在6~18之间，只能包含字母、数字和下划线)
    var isValidPasswd:Bool{
        NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z]\\w{5,17}$").evaluate(with: self)
    }
    /// 提取匹配的正则表达式
    /// refer: https://blog.csdn.net/qq_14920635/article/details/77689830
    func regexGetSub(pattern:String) -> [String] {
            var subStr = [String]()
            let regex = try! NSRegularExpression(pattern: pattern, options:[NSRegularExpression.Options.caseInsensitive])
            let results = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, self.count))
            //解析出子串
            for  rst in results {
                let nsStr = self as NSString  //可以方便通过range获取子串
                subStr.append(nsStr.substring(with: rst.range))
            }
            return subStr
        }
    
}
