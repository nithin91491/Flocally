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
        
        var url:NSURL = NSURL(string: baseURL.rawValue)!
        let session = NSURLSession.sharedSession()
        
        var request = NSMutableURLRequest(URL: url)
        
        switch type{
        case .GET : request.HTTPMethod = "GET"
        case .POST :request.HTTPMethod = "POST"
        }
        
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        if let paramString = parameterString{
            if type == .POST{
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
            }
            else{
             let  urlWithParameters = baseURL.rawValue + parameterString!
                url = NSURL(string: urlWithParameters)!
                request = NSMutableURLRequest(URL: url)
            }
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
    
    
    static func postRequest(baseURL:BaseURL,params:Dictionary<String, AnyObject>,block:(data:JSON)->()){
        
        let url:NSURL = NSURL(string: baseURL.rawValue)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        
        
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        request.HTTPMethod = "POST"
        
        do{
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.init(rawValue: 0))
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
        }
        catch{
            print("Error writing JSON: ")
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
            
        }
        
        task.resume()
        
    }

}