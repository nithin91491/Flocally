//
//  AppDelegate.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/4/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics


let downloader = Downloader(configuration: NSURLSession.sharedSession().configuration)
var itemsToCheckout:[[String:AnyObject]]!
var total:Double = 0.0
let convenienceFee = 20.0
let taxes = 15.0
var userName = ""
var userID = ""  {      //"56b30eb1f27e7d5a0d8e583e"
    willSet{
        let param = "/\(newValue)"
        RequestManager.request(.GET, baseURL: .getUserDetails, parameterString: param) { (data) in
            userName = data[0]["name"].stringValue
            userPhoneNumber = data[0]["phone"].stringValue
        }
    }
    
}

var latitude:String!
var longitude:String!
var deviceID = "sampledeviceid"
var userPhoneNumber = ""

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
 

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self])
        
        if   NSUserDefaults.standardUserDefaults().valueForKey("userid") as? String != nil {
            userID = NSUserDefaults.standardUserDefaults().valueForKey("userid") as! String
        }
        
//        if   NSUserDefaults.standardUserDefaults().valueForKey("username") as? String != nil {
//            userName = NSUserDefaults.standardUserDefaults().valueForKey("username") as! String
//        }
        
        let types:UIUserNotificationType = ([.Alert, .Sound, .Badge])
        let settings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        
        let infos = toHexString(deviceToken)
        deviceID = infos
        print("Device Token:" + deviceID)
        
        
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        //deviceTok = "1234"
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        // let temp : NSDictionary = userInfo
        
//        if let info = userInfo["aps"] as? Dictionary<String, AnyObject>
//        {
//            //            if let badge = info["badge"]  {
//            //                application.applicationIconBadgeNumber = (badge as! NSString).integerValue
//            //            }
//            
//        }
    }
    
    func toHexString(HString: NSData) -> String {
        
        var hexString: String = ""
        let dataBytes =  UnsafePointer<CUnsignedChar>(HString.bytes)
        
        for (var i: Int=0; i<HString.length; ++i) {
            hexString +=  String(format: "%02X", dataBytes[i])
        }
        
        return hexString
    }

}

