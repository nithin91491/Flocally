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
    
    var dish:Dish!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imgDishImage.image = dish.dishImage
        self.lblDishName.text = dish.name
        self.lblPrice.text =  "₹"+String(dish.price)
        self.txvDescription.text = dish.description
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
