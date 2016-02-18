//
//  BreakfastTableViewCell.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/6/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFoodImage: UIImageView!
    
    @IBOutlet weak var imgProfileImage: UIImageView!
    
    @IBOutlet weak var lblFoodName: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblNumberOfServingsLeft: UILabel!
    
    @IBOutlet weak var lblDistance: UILabel!
    
    @IBOutlet weak var lblQuantity: UILabel!
    
    @IBOutlet weak var imgVegIndicator: UIImageView!
    
    @IBOutlet weak var lblDescription: UILabel!
 
    @IBOutlet weak var lblChefName: UILabel!
    
    @IBOutlet weak var ratingView: RatingView!
    
    @IBOutlet weak var btnPlus:UIButton!
    
    var dishID:String!
    var breakfastVC:BreakFastTableViewController?
    var lunchVC:LunchTableViewController?
    var snacksVC:SnacksTableViewController?
    var dinnerVC:DinnerTableViewController?
    
    var initialQuantity = 0
    var userSelectedQuantity:Int?
    var shouldAdd = true
    @IBAction func changeQuantity(sender: UIButton) {
        
        if sender.tag >= 0{ //Increment
            self.lblQuantity.text = String(++initialQuantity)
            shouldAdd = true
            
            breakfastVC?.quantityArray[sender.tag] = initialQuantity
            lunchVC?.quantityArray[sender.tag] = initialQuantity
            snacksVC?.quantityArray[sender.tag] = initialQuantity
            dinnerVC?.quantityArray[sender.tag] = initialQuantity
        }
        else{ //Decrement
            guard initialQuantity > 0 else {return}
            self.lblQuantity.text = String(--initialQuantity)
            shouldAdd = false
        }
        
        
        
        
        let price = Double((self.lblPrice.text!.stringByReplacingOccurrencesOfString("₹", withString: "")))!
        let dishName = self.lblFoodName.text!
        
        
        NSNotificationCenter.defaultCenter().postNotificationName("cartItemChanged", object: self, userInfo: ["price":price,"dishName":dishName,"quantity":initialQuantity,"dishID":dishID]) //Observer-ViewController
    }
    
    
    override func prepareForReuse() {
        self.lblQuantity.text = "0"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.imgFoodImage.addBottomGradient(UIColor.blackColor().CGColor as CGColorRef)
//        let gradientlayer = self.imgFoodImage.layer.sublayers?.filter{$0.name == "gradientLayer"}.first!
//        gradientlayer!.hidden = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
