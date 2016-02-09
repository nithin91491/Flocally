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
    
    
    var initialQuantity = 0
    var userSelectedQuantity:Int?
    var shouldAdd = true
    @IBAction func changeQuantity(sender: UIButton) {
        
        if sender.tag == 1{ //Increment
            self.lblQuantity.text = String(++initialQuantity)
            shouldAdd = true
        }
        else{ //Decrement
            guard initialQuantity > 0 else {return}
            self.lblQuantity.text = String(--initialQuantity)
            shouldAdd = false
        }
        
        
        let price = Double((self.lblPrice.text!.stringByReplacingOccurrencesOfString("₹", withString: "")))!
        
        NSNotificationCenter.defaultCenter().postNotificationName("QuantityChanged", object: self, userInfo: ["totalAmount":price,"shouldAdd":shouldAdd])
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgFoodImage.addBottomGradient(UIColor.blackColor().CGColor as CGColorRef)
        let gradientlayer = self.imgFoodImage.layer.sublayers?.filter{$0.name == "gradientLayer"}.first!
        gradientlayer!.hidden = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
