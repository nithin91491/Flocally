//
//  DishScreenViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/27/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class DishScreenViewController: UIViewController {

    
    @IBOutlet weak var imgDishImage: UIImageView!
    
    @IBOutlet weak var lblDishName: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var txvDescription: UILabel!
    
    @IBOutlet weak var imgVegIndicator: UIImageView!
    
    @IBOutlet weak var lblQuantity: UILabel!
    
    var dish:Dish!
    var initialQuantity:Int = 0
    
    
    
    @IBAction func changeQuantity(sender: UIButton) {
        if sender.tag == 1{ //Increment
            self.lblQuantity.text = String(++initialQuantity)
        }
        else{ //Decrement
            guard initialQuantity > 0 else {return}
            self.lblQuantity.text = String(--initialQuantity)
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imgDishImage.image = dish.dishImage
        self.lblDishName.text = dish.name
        self.lblPrice.text =  "₹"+String(dish.price)
        self.txvDescription.text = dish.description
        self.lblQuantity.text = String(initialQuantity)
        
        if dish.category == "non-veg"{
            imgVegIndicator.image = UIImage(named: "nonveg")
        }else{
            imgVegIndicator.image = UIImage(named: "veg")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//    }
    

}
