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
    
    var initialQuantity = 0
    var userSelectedQuantity:Int?
    
    @IBAction func changeQuantity(sender: UIButton) {
        if sender.tag == 1{ //Increment
            self.lblQuantity.text = String(++initialQuantity)
        }
        else{ //Decrement
            guard initialQuantity > 0 else {return}
            self.lblQuantity.text = String(--initialQuantity)
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
