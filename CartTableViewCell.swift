//
//  CartTableViewCell.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/15/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblDishName: UILabel!
    
    @IBOutlet weak var lblQuantity: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var btnPlus: UIButton!
    
    @IBOutlet weak var btnMinus: UIButton!
    
    
    var initialQuantity = 0
    var Amount = 0.0
    
    @IBAction func changeQuantity(sender: UIButton) {
        
        let price = Double((self.lblPrice.text!.stringByReplacingOccurrencesOfString("₹", withString: "")))!
        if sender.tag == 1{ //Increment
            self.lblQuantity.text = String(++initialQuantity)
           NSNotificationCenter.defaultCenter().postNotificationName("quantityChanged", object: self, userInfo: ["amount":price]) //Observer - Cart View Controller
        }
        else{ //Decrement
            guard initialQuantity > 0 else {return}
            self.lblQuantity.text = String(--initialQuantity)
            NSNotificationCenter.defaultCenter().postNotificationName("quantityChanged", object: self, userInfo: ["amount":-price]) //Observer - Cart View Controller
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
