//
//  WebServiceURLs.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/22/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import Foundation

enum BaseURL : String {
    
    case getChef = "http://52.35.39.21:3000/api/getchef"
    case getDish = "http://52.35.39.21:3000/api/getdish"
    case addChefDishReview = "http://52.35.39.21:3000/api/addchefdishreview"
    case getChefReview = "http://52.35.39.21:3000/api/getchefreview"
    case followChef = "http://52.35.39.21:3000/api/followchef"
    case unfollowChef = "http://52.35.39.21:3000/api/unfollowchef"
    case getChefDetails = "http://52.35.39.21:3000/api/getchefdetails"
    case postSMS = "http://flocally.com/api/sms.php"
    case generateOTP = "http://52.35.39.21:3000/api/generateotp"
    case validateOTP = "http://52.35.39.21:3000/api/validateotp"
}