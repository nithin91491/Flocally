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
    var id:String
    
    init(address:String,id:String){
        
        let addressItems = address.componentsSeparatedByString(",")
        self.addressLine1 = addressItems[0]
        self.addressLine2 = addressItems[1]
        self.state = addressItems[2]
        self.city = addressItems[3]
        self.pinCode = addressItems[4]
        self.id = id
        //super.init()
    }
    
    convenience init(address:String){
        self.init(address:address,id:"")
    }
    
//    required init(coder aDecoder: NSCoder) {
//        
//       addressLine1 = aDecoder.decodeObjectForKey("addressLine1") as! String
//        addressLine2 = aDecoder.decodeObjectForKey("addressLine2") as! String
//        state = aDecoder.decodeObjectForKey("state") as! String
//        city = aDecoder.decodeObjectForKey("city") as! String
//        pinCode = aDecoder.decodeObjectForKey("pincode") as! String
//        //key = aDecoder.decodeObjectForKey("key") as! String
//    }
    
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(addressLine1, forKey: "addressLine1")
//        aCoder.encodeObject(addressLine2, forKey: "addressLine2")
//        aCoder.encodeObject(state, forKey: "state")
//        aCoder.encodeObject(city, forKey: "city")
//        aCoder.encodeObject(pinCode, forKey: "pincode")
//        //aCoder.encodeObject(key, forKey: "key")
//    }
    
}