//
//  SnacksTableViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/5/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class SnacksTableViewController: UITableViewController {

    //MARK :- Properties and Outlets
    var snacks = [Dish]()
    
    
    //MARK :- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.snacks = DataManager.sharedInstance.dishes.filter{$0.type == "Snacks"}
    }

    
    
    //Mark :- Functions
    func profileTapped(sender:UITapGestureRecognizer){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.performSegueWithIdentifier("ChefSegue", sender: sender)
        }
        
    }
    

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.snacks.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SnacksCell", forIndexPath: indexPath) as! CustomTableViewCell

        let snacks = self.snacks[indexPath.row] as Dish
        
        cell.lblPrice.text = "₹"+String(snacks.price)
        cell.lblFoodName.text = snacks.name
        cell.lblDescription.text = snacks.description
        cell.lblChefName.text = snacks.postedByName
        
        let tap1 = UITapGestureRecognizer(target: self, action: "profileTapped:")
        let tap2 = UITapGestureRecognizer(target: self, action: "profileTapped:")
        cell.imgProfileImage.userInteractionEnabled = true
        cell.imgProfileImage.addGestureRecognizer(tap1)
        cell.imgProfileImage.tag = indexPath.row
        cell.lblChefName.userInteractionEnabled = true
        cell.lblChefName.addGestureRecognizer(tap2)
        cell.lblChefName.tag = indexPath.row
        
        if snacks.category == "non-veg"{
            cell.imgVegIndicator.image = UIImage(named: "nonveg")
        }else{
            cell.imgVegIndicator.image = UIImage(named: "veg")
        }
        
        if let chefImage = snacks.postedByImage {
            cell.imgProfileImage.image = chefImage
            cell.imgProfileImage.contentMode = .ScaleAspectFill
        }
        else{
            cell.imgProfileImage.image = nil
            downloader.download(snacks.postedByImageURL, completionHandler: { url in
                
                guard url != nil else {return}
                
                let data = NSData(contentsOfURL: url)!
                let image = UIImage(data:data)
                
                dispatch_async(dispatch_get_main_queue()) {
                    snacks.postedByImage = image
                    self.tableView.reloadRowsAtIndexPaths(
                        [indexPath], withRowAnimation: .None)
                }
                
            })
        }
        
        if let foodImage = snacks.dishImage{
            cell.imgFoodImage.image = foodImage
            cell.imgFoodImage.contentMode = .ScaleAspectFill
            let gradientlayer = cell.imgFoodImage.layer.sublayers?.filter{$0.name == "gradientLayer"}.first!
            gradientlayer!.hidden = false
        }
        else{
            
            cell.imgFoodImage.image = nil
            downloader.download(snacks.dishImageURL, completionHandler: { url in
                
                guard url != nil else {return}
                
                let data = NSData(contentsOfURL: url)!
                let image = UIImage(data:data)
                
                dispatch_async(dispatch_get_main_queue()) {
                    snacks.dishImage = image
                    self.tableView.reloadRowsAtIndexPaths(
                        [indexPath], withRowAnimation: .None)
                }
                
            })
        }

        cell.selectionStyle = .None
        return cell
    }
    

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
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
            let chefID = self.snacks[selectedRow].postedByID
            let chef = DataManager.sharedInstance.chefs.filter({ $0._id == chefID  })
            
            
            destinationVC.chef = chef.first
            
        }
        else if segue.identifier == "DishSegue"{
            
            let selectedRow = self.tableView.indexPathForSelectedRow!
            let selectedDish = snacks[selectedRow.row]
            let destinationVC = segue.destinationViewController as! DishScreenViewController
            destinationVC.dish = selectedDish
            destinationVC.initialQuantity = (self.tableView.cellForRowAtIndexPath(selectedRow) as! CustomTableViewCell).initialQuantity
        }

    }
    

}
