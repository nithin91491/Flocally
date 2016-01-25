//
//  RequestManager.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/22/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import Foundation
//import SwiftyJSON

enum RequestType{
    case GET
    case POST
}

class RequestManager{
    
    static func request(type:RequestType,baseURL:BaseURL,parameterString:String?,block:(data:JSON)->()){
        
        let url:NSURL = NSURL(string: baseURL.rawValue)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        
        switch type{
        case .GET : request.HTTPMethod = "GET"
        case .POST :request.HTTPMethod = "POST"
        }
        
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        if let paramString = parameterString{
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error  No data")
                return
            }
           
            
            let json = JSON(data: data!)
            
            dispatch_async(dispatch_get_main_queue()){
                block(data: json)
            }
           
            
//            do{
//                let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as? [[String:AnyObject]]
//                
//                if let data = json{
//                    dispatch_async(dispatch_get_main_queue()){
//                        block(data: data)
//                    }
//                }
//                else {
//                    print("json parsing failed")
//                }
//                
//            }
//            catch let error as NSError{
//                print(error)
//            }
            
        }
        
        task.resume()
        
    }
    
}