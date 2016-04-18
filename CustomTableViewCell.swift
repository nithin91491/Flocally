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
    
    @IBOutlet weak var btnMinus:UIButton!
    
    var dishID:String!
    var postedByChefID:String!
    var breakfastVC:BreakFastTableViewController?
    var lunchVC:LunchTableViewController?
    var snacksVC:SnacksTableViewController?
    var dinnerVC:DinnerTableViewController?
    
    var initialQuantity = 0
    //var userSelectedQuantity:Int?
   // var shouldAdd = true
    @IBAction func changeQuantity(sender: UIButton) {
        
//        
        if let breakfast = breakfastVC{
            initialQuantity = breakfast.quantityArray[abs(sender.tag)-1]
        }
        if let lunch = lunchVC{
            initialQuantity = lunch.quantityArray[abs(sender.tag)-1]
        }
        if let snacks = snacksVC{
            initialQuantity = snacks.quantityArray[abs(sender.tag)-1]
        }
        if let dinner = dinnerVC{
            initialQuantity = dinner.quantityArray[abs(sender.tag)-1]
        }
        
        
        if sender.tag > 0{ //Increment
            
            self.lblQuantity.text = String(++initialQuantity)
            //shouldAdd = true
            
        }
        else{ //Decrement
            guard initialQuantity > 0 else {return}
            self.lblQuantity.text = String(--initialQuantity)
            //shouldAdd = false
        }
        
        breakfastVC?.quantityArray[abs(sender.tag)-1] = initialQuantity
        lunchVC?.quantityArray[abs(sender.tag)-1] = initialQuantity
        snacksVC?.quantityArray[abs(sender.tag)-1] = initialQuantity
        dinnerVC?.quantityArray[abs(sender.tag)-1] = initialQuantity
        
        
        let price = Double((self.lblPrice.text!.stringByReplacingOccurrencesOfString("₹", withString: "")))!
        let dishName = self.lblFoodName.text!
        
        
        NSNotificationCenter.defaultCenter().postNotificationName("cartItemChanged", object: self, userInfo: ["price":price,"dishName":dishName,"quantity":initialQuantity,"dishID":dishID,"postedByID":postedByChefID]) //Observer-ViewController
    }
    
    
    override func prepareForReuse() {
        //self.lblQuantity.text = "0"
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
