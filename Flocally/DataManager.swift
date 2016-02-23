//
//  DataManager.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/28/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import Foundation

class DataManager {
    static let sharedInstance = DataManager()
    
     var dishes = [Dish]()
     var chefs = [Chef]()
    private var requestCompletionHandler : [()->()] = []
     private var isDishDownloaded = false
    
    private init(){
        
    }
    
    func downloadDishes(completion:()->()){
        RequestManager.request(.GET, baseURL: .getDish, parameterString: nil) {[unowned self] (jsonData) -> () in
            
            jsonData.forEach({ (dish: (String, JSON)) -> () in
                
                let dishJSON = dish.1
                
                let dishes = dishJSON["dishes"].arrayValue
                
                dishes.forEach({ (JSON) -> () in
                    
                    let id:String = JSON["_id"].stringValue
                    let name:String = JSON["name"].stringValue
                    let type:String = JSON["type"].stringValue
                    let category:String = JSON["category"].stringValue
                    let description:String = JSON["desc"].stringValue
                    let price:Double = JSON["price"].doubleValue
                    let imageURL:String = JSON["image_url"].stringValue
                    let imageURLArray = JSON["image_urls"].arrayValue
                    let postedByName:String = dishJSON["name"].stringValue
                    let postedByImageURL:String = dishJSON["profilepicture"].stringValue
                    let postedByID:String = dishJSON["_id"].stringValue
                    
                    let dish = Dish(id:id,name: name,type: type,category: category,description: description,price: price,postedByName: postedByName,postedByImageURL: postedByImageURL,postedByID: postedByID,dishImageURL:imageURL,dishImageURLArray: imageURLArray)
                    
                    self.dishes.append(dish)
                })
                //
                //                let id:String = dishJSON["_id"].stringValue
                //                let name:String = dishJSON["name"].stringValue
                //                let type:String = dishJSON["type"].stringValue
                //                let category:String = dishJSON["category"].stringValue
                //                let description:String = dishJSON["desc"].stringValue
                //                let price:Double = dishJSON["price"].doubleValue
                //                let postedByName:String = dishJSON["posted_by_name"].stringValue
                //                let postedByImageURL:String = dishJSON["posted_by_image"].stringValue
                //                let postedByID:String = dishJSON["posted_by_id"].stringValue
                //
                //                let dish = Dish(id:id,name: name,type: type,category: category,description: description,price: price,postedByName: postedByName,postedByImageURL: postedByImageURL,postedByID: postedByID,chefImage: nil)
                //                
                //                self.dishes.append(dish)
                
            })
            
            completion()
            self.isDishDownloaded = true
            
            if self.requestCompletionHandler.count > 0{
                for ch in self.requestCompletionHandler{
                   ch()
                }
            }
            //self.requestCompletionHandler = nil
        }
    }
    
    func downloadChefs(completion:()->()){
        RequestManager.request(.GET, baseURL: .getChef, parameterString: nil) { (jsonData) -> () in
            
            jsonData.forEach({ (chef:(String, JSON)) -> () in
                
                let chefJSON = chef.1
                
                let _v:String = chefJSON["_v"].stringValue
                let _id:String = chefJSON["_id"].stringValue
                let dob:String = chefJSON["dob"].stringValue
                let emailAddress:String = chefJSON["emailaddress"].stringValue
                let name:String = chefJSON["name"].stringValue
                let password:String = chefJSON["password"].stringValue
                let longitude:Double = chefJSON["longitude"].doubleValue
                let latitude:Double = chefJSON["latitude"].doubleValue
                let profileCreateTimestamp:String = chefJSON["profileCreateTimestamp"].stringValue
                let dishes:[JSON] = chefJSON["dishes"].arrayValue
                let tags:[JSON] = chefJSON["tags"].arrayValue
                let ratings:[JSON] = chefJSON["ratings"].arrayValue
                let phones:[JSON] = chefJSON["phones"].arrayValue
                let followers:[JSON] = chefJSON["followers"].arrayValue
                let addresses:[JSON] = chefJSON["addresses"].arrayValue
                let aboutme:String = chefJSON["aboutme"].stringValue
                let googleplusid:String = chefJSON["aboutme"].stringValue
                let fbid:String = chefJSON["googleplusid"].stringValue
                let profilePictureURL:String = chefJSON["profilepicture"].stringValue
                let gender:String = chefJSON["gender"].stringValue
                let deviceId:String = chefJSON["deviceid"].stringValue
                let deviceType:String = chefJSON["devicetype"].stringValue
                
                let chef = Chef(_v:_v,_id: _id,dob: dob,emailAddress: emailAddress,name: name,password: password,longitude: longitude,latitude: latitude,profileCreateTimestamp: profileCreateTimestamp,dishes: dishes,tags: tags,ratings: ratings,phones: phones,followers: followers,addresses: addresses,aboutme: aboutme,googleplusid: googleplusid,fbid: fbid,profilePictureURL: profilePictureURL,gender: gender,deviceId: deviceId,deviceType: deviceType)
                
                self.chefs.append(chef)
                
                
            })
            
            completion()
            
        }

    }
    
    func ifDishAvailable(completion:()->()){
        if isDishDownloaded{
            completion()
        }else{
        requestCompletionHandler.append(completion)
        }
    }
    
    func clearImageCache(){
        
        for dish in self.dishes{
            dish.dishImage1 = nil
            dish.dishImage2 = nil
            dish.dishImage3 = nil
        }
    }
    
}