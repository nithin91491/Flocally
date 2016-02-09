//
//  BreakFastTableViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/4/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit



class BreakFastTableViewController: UITableViewController {
    
    //MARK:- Properties and Outlets
     var breakfast=[Dish]()
     var chefs=[Chef]()
    
    
    var rateChefVC:RateChefViewController!
    
    
    //MARK:- IBActions
    
       

    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.sharedInstance.downloadDishes{
            self.breakfast = DataManager.sharedInstance.dishes.filter{$0.type == "Breakfast"}
            self.tableView.reloadData()
        }
        
        DataManager.sharedInstance.downloadChefs{
            self.chefs = DataManager.sharedInstance.chefs
        }
        
         rateChefVC = self.storyboard?.instantiateViewControllerWithIdentifier("RateChef") as! RateChefViewController
        
        
    
    }

    
    
    

    
    //MARK:- Functions
    func profileTapped(sender:UITapGestureRecognizer){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.performSegueWithIdentifier("ChefSegue", sender: sender)
        }
    }

    
    func rateChef(sender:UITapGestureRecognizer){
        self.performSegueWithIdentifier("RateChef", sender: sender)
    }
    
    
    
    
    
    
    
    
    // MARK:- Table view

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breakfast.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BreakFastCell", forIndexPath: indexPath) as! CustomTableViewCell

        let breakfast = self.breakfast[indexPath.row] as Dish
        
        cell.lblPrice.text = "₹"+String(breakfast.price)
        cell.lblFoodName.text = breakfast.name
        cell.lblDescription.text = breakfast.description
        cell.lblChefName.text = breakfast.postedByName
        
        let tap1 = UITapGestureRecognizer(target: self, action: "profileTapped:")
        let tap2 = UITapGestureRecognizer(target: self, action: "profileTapped:")
        cell.imgProfileImage.userInteractionEnabled = true
        cell.imgProfileImage.addGestureRecognizer(tap1)
        cell.imgProfileImage.tag = indexPath.row
        cell.lblChefName.userInteractionEnabled = true
        cell.lblChefName.addGestureRecognizer(tap2)
        cell.lblChefName.tag = indexPath.row
        
        if breakfast.category == "non-veg"{
            cell.imgVegIndicator.image = UIImage(named: "nonveg")
        }else{
            cell.imgVegIndicator.image = UIImage(named: "veg")
        }
        
        let tap3 = UITapGestureRecognizer(target: self, action: "rateChef:")
        cell.ratingView.addGestureRecognizer(tap3)
        cell.ratingView.tag = indexPath.row
    
        if let chefImage = breakfast.postedByImage {
            cell.imgProfileImage.image = chefImage
            cell.imgProfileImage.contentMode = .ScaleAspectFill
        }
        else{
            cell.imgProfileImage.image = nil
            downloader.download(breakfast.postedByImageURL, completionHandler: { url in
                
                guard url != nil else {return}
                
                let data = NSData(contentsOfURL: url)!
                let image = UIImage(data:data)
                
                dispatch_async(dispatch_get_main_queue()) {
                    breakfast.postedByImage = image
                    self.tableView.reloadRowsAtIndexPaths(
                            [indexPath], withRowAnimation: .None)
                }
                
            })
        }
        
        if let foodImage = breakfast.dishImage{
          
            cell.imgFoodImage.image = foodImage
            cell.imgFoodImage.contentMode = .ScaleAspectFill
            let gradientlayer = cell.imgFoodImage.layer.sublayers?.filter{$0.name == "gradientLayer"}.first!
            gradientlayer!.hidden = false
        }
        else{
            
            cell.imgFoodImage.image = nil
            downloader.download(breakfast.dishImageURL, completionHandler: { url in
            
            guard url != nil else {return}
            
            let data = NSData(contentsOfURL: url)!
            let image = UIImage(data:data)
            
            dispatch_async(dispatch_get_main_queue()) {
                breakfast.dishImage = image
                self.tableView.reloadRowsAtIndexPaths(
                [indexPath], withRowAnimation: .None)
            }
            
            })
        }
        
        cell.selectionStyle = .None
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 282.0
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ChefSegue"{
    
    
        let destinationVC = segue.destinationViewController as! ChefScreenViewController
            let sender = sender as! UITapGestureRecognizer
            let selectedRow = sender.view!.tag
            let chefID = self.breakfast[selectedRow].postedByID
            let chef = self.chefs.filter({ $0._id == chefID  })
            
    
            destinationVC.chef = chef.first
    
        }
        else if segue.identifier == "DishSegue"{
    
            let selectedRow = self.tableView.indexPathForSelectedRow!
            let selectedDish = breakfast[selectedRow.row]
            let destinationVC = segue.destinationViewController as! DishScreenViewController
            destinationVC.dish = selectedDish
            destinationVC.initialQuantity = (self.tableView.cellForRowAtIndexPath(selectedRow) as! CustomTableViewCell).initialQuantity
        }
        
        if segue.identifier == "RateChef" {
            
            let sender = sender as! UITapGestureRecognizer
            let selectedRow = sender.view!.tag
            let selectedDish = breakfast[selectedRow]
            let destinationVC = segue.destinationViewController as! RateChefViewController
            destinationVC.dish = selectedDish
        }
        
    }


}
