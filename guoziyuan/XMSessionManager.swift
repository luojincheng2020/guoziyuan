//
//  XMSessionManager.swift
//  guoziyuan
//
//  Created by aibaimm on 2017/8/20.
//  Copyright © 2017年 guoziyuan. All rights reserved.
//

import AFNetworking

/// 枚举-请求方法
///
/// - GET: GET
/// - POST: POST
enum XMHTTPMethod {
    case GET
    case POST
}


class XMSessionManager: AFHTTPSessionManager {

    
    
    /// 创建网络请求单例
    static let shared: XMSessionManager = XMSessionManager()
    
 
    /// 如果需要设置请求的属性,可在闭包中添加
    /// 在第一次访问时，执行闭包，并且将结果保存在 shared 常量中
    static let shared1: XMSessionManager = {
        
        // 实例化对象
        let manager = XMSessionManager()
        
        // 设置响应反序列化支持的数据类型
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        // 返回对象
        return manager
    }()
    
    
    
    
    
    /// 封装网络请求方法
    ///
    /// - Parameters:
    ///   - Method: GET/POST, 默认是GET请求
    ///   - URLString: 请求地址
    ///   - parameters: 参数
    ///   - completed: 结束回调
    func request(Method:XMHTTPMethod, URLString: String,parameters: [String: AnyObject]?, completed:@escaping ((_ json: AnyObject?, _ isSuccess: Bool)->())) {
        XMSessionManager().requestSerializer.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        /// 定义成功回调闭包
        let success = { (task: URLSessionDataTask,json: Any?)->() in
            completed(json as AnyObject?,true)
        }
        
        /// 定义失败回调闭包
        let failure = {(task: URLSessionDataTask?, error: Error)->() in
            completed(nil,false)
        }
        
        /// 通过请求方法,执行不同的请求
        // 如果是 GET 请求
        if Method == .GET { // GET
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
            
        } else { // POST
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    
    
}
