//
//  Address.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 4/12/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import Foundation

class Address{
    
    var addressLine1:String
    var addressLine2:String
    var state:String
    var city:String
    var pinCode:String
    var key:String
    
     init(addressLine1:String,addressLine2:String,state:String,city:String,pinCode:String,key:String){
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.state = state
        self.city = city
        self.pinCode = pinCode
        self.key = key
        //super.init()
    }
    
//    required init(coder aDecoder: NSCoder) {
//        
//        self.addressLine1 = aDecoder.decodeObjectForKey("addressLine1") as! String
//        self.addressLine2 = aDecoder.decodeObjectForKey("addressLine2") as! String
//        
//    }
    
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(addressLine1, forKey: "addressLine1")
//        aCoder.encodeObject(addressLine2, forKey: "addressLine2")
//    }
    
}