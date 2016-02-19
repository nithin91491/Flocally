//
//  Dish.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/22/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import Foundation

class Dish {
    
    var id:String
    var name:String
    var type:String
    var category:String
    var description:String
    var price:Double
    var postedByName:String
    var postedByImageURL:String
    var postedByID:String
    var dishImageURL:String
    var dishImageURLArray:[JSON]
    var postedByImage:UIImage!
    var dishImage:UIImage!
    
    init(id:String,name:String,type:String,category:String,description:String,price:Double,postedByName:String,postedByImageURL:String,postedByID:String,dishImageURL:String,dishImageURLArray:[JSON]){
        
        self.id = id
        self.name = name
        self.type = type
        self.category = category
        self.description = description
        self.price = price
        self.postedByName = postedByName
        self.postedByImageURL = postedByImageURL
        self.postedByID = postedByID
        self.dishImageURL = dishImageURL
        self.dishImageURLArray = dishImageURLArray
    }
    
    
}