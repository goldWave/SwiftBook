//
//  NetManager.swift
//  Book_Swift
//
//  Created by 任金波 on 16/3/26.
//  Copyright © 2016年 任金波. All rights reserved.
//

import UIKit

struct  NetManager {
    static func GETMEthod(url:String,parame:[String:NSObject]?,success:((NSObject?) -> Void?),failure:((NSError) -> Void?)) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        
        
        manager.GET(url, parameters: parame, success: { (task, responseObject) in
            
            success(responseObject as? NSObject)
            }) { (task, error) in
                
                failure(error)
        }
        
        }
}
