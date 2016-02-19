//
//  Downloader.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/22/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import Foundation

class Wrapper<T> {
    let p:T
    init(_ p:T){self.p = p}
}

typealias MyDownloaderCompletion = (NSURL!) -> ()

class Downloader: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate {
    
    let config : NSURLSessionConfiguration
    
    lazy var session : NSURLSession = {
        let queue = NSOperationQueue.mainQueue()
        return NSURLSession(configuration:self.config,
        delegate:self, delegateQueue:queue)
    }()
    init(configuration config:NSURLSessionConfiguration) {
        self.config = config
        super.init()
    }
    func download(s:String, completionHandler ch : MyDownloaderCompletion)
        -> NSURLSessionTask {
            let urlString = s.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url = NSURL(string:urlString)!
        let req = NSMutableURLRequest(URL:url)
        NSURLProtocol.setProperty(Wrapper(ch), forKey:"ch", inRequest:req)
        let task = self.session.downloadTaskWithRequest(req)
        task.resume()
        return task
    }
    func URLSession(session: NSURLSession,
        downloadTask: NSURLSessionDownloadTask,
        didFinishDownloadingToURL location: NSURL) {
        let req = downloadTask.originalRequest!
        let ch : AnyObject =
        NSURLProtocol.propertyForKey("ch", inRequest:req)!
        let response = downloadTask.response as! NSHTTPURLResponse
        let stat = response.statusCode
        var url : NSURL! = nil
        if stat == 200 {
        url = location
        }
        let ch2 = (ch as! Wrapper).p as MyDownloaderCompletion
        ch2(url) }
    func cancelAllTasks() {
        self.session.invalidateAndCancel()
    }
}