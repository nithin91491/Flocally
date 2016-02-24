//
//  LunchTableViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/5/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class LunchTableViewController: UITableViewController,updateUserSelectedQuantity {

    //MARK:- Properties and Outlets
    var lunch = [Dish]()
    var quantityArray = [Int]()
    
    
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.sharedInstance.ifDishAvailable{ [unowned self] in
        self.lunch = DataManager.sharedInstance.dishes.filter{$0.type == "Lunch"}
            for _ in 1...self.lunch.count{
                self.quantityArray.append(0)
            }
        self.tableView.reloadData()
            
            //For early loading of dish images
            for (index,lunch) in self.lunch.enumerate(){
                
                if lunch.dishImageURL == "" && lunch.dishImageURLArray.count > 0 {
                    let imageURL = lunch.dishImageURLArray[0]["image_url"].stringValue
                    
                    
                    downloader.download(imageURL, completionHandler: { url in
                        
                        guard url != nil else {return}
                        
                        let data = NSData(contentsOfURL: url)!
                        let image = UIImage(data:data)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            lunch.dishImage = image
                            self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .None)
                        }
                        
                    })
                    
                    
                }
                else{
                    
                    
                    downloader.download(lunch.dishImageURL, completionHandler: { url in
                        
                        guard url != nil else {return}
                        
                        let data = NSData(contentsOfURL: url)!
                        let image = UIImage(data:data)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            lunch.dishImage = image
                            self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .None)
                        }
                        
                    })
                }
            }
            
        }
    
    }

    //Update quantity delegate method
    func updateQuantityForRow(row: Int,quantity:Int) {
        self.quantityArray[row] = quantity
        self.tableView.reloadData()
    }
    
    
    // MARK: - Functions
    func profileTapped(sender:UITapGestureRecognizer){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.performSegueWithIdentifier("ChefSegue", sender: sender)
        }
        
    }
    
    func rateChef(sender:UITapGestureRecognizer){
        self.performSegueWithIdentifier("RateChef", sender: sender)
    }
    
    // MARK: - Table view
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lunch.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LunchCell", forIndexPath: indexPath) as! CustomTableViewCell
        let lunch = self.lunch[indexPath.row] as Dish
        
        cell.dishID = lunch.id
        cell.lblPrice.text = "₹"+String(lunch.price)
        cell.lblFoodName.text = lunch.name
        cell.lblDescription.text = lunch.description
        cell.lblChefName.text = lunch.postedByName
        
        
        cell.btnPlus.tag = indexPath.row + 1
        cell.btnMinus.tag = -(indexPath.row+1)
        cell.lunchVC = self
        cell.lblQuantity.text = "\(quantityArray[indexPath.row])"
        
        let tap1 = UITapGestureRecognizer(target: self, action: "profileTapped:")
        let tap2 = UITapGestureRecognizer(target: self, action: "profileTapped:")
        cell.imgProfileImage.userInteractionEnabled = true
        cell.imgProfileImage.addGestureRecognizer(tap1)
        cell.imgProfileImage.tag = indexPath.row
        cell.lblChefName.userInteractionEnabled = true
        cell.lblChefName.addGestureRecognizer(tap2)
        cell.lblChefName.tag = indexPath.row
        
        
        let tap4 = UITapGestureRecognizer(target: self, action: "rateChef:")
        cell.ratingView.addGestureRecognizer(tap4)
        cell.ratingView.tag = indexPath.row
        
        
        if lunch.category == "non-veg"{
            cell.imgVegIndicator.image = UIImage(named: "nonveg")
        }else{
            cell.imgVegIndicator.image = UIImage(named: "veg")
        }
        
        if let chefImage = lunch.postedByImage {
            cell.imgProfileImage.image = chefImage
            cell.imgProfileImage.contentMode = .ScaleAspectFill
        }
        else{
            cell.imgProfileImage.image = nil
            downloader.download(lunch.postedByImageURL, completionHandler: { url in
                
                guard url != nil else {return}
                
                let data = NSData(contentsOfURL: url)!
                let image = UIImage(data:data)
                
                dispatch_async(dispatch_get_main_queue()) {
                    lunch.postedByImage = image
                    self.tableView.reloadRowsAtIndexPaths(
                        [indexPath], withRowAnimation: .None)
                }
                
            })
        }
        
        if let foodImage = lunch.dishImage{
            cell.imgFoodImage.image = foodImage
            cell.imgFoodImage.contentMode = .ScaleAspectFill
            let gradientlayer = cell.imgFoodImage.layer.sublayers?.filter{$0.name == "gradientLayer"}.first!
            gradientlayer!.hidden = false
        }
        else{
            
            cell.imgFoodImage.image = UIImage(named: "dummy-image")
            
            if lunch.dishImageURL == "" && lunch.dishImageURLArray.count > 0 {
                
                let imageURL = lunch.dishImageURLArray[0]["image_url"].stringValue
                downloader.download(imageURL, completionHandler: { url in
                    
                    guard url != nil else {return}
                    
                    let data = NSData(contentsOfURL: url)!
                    let image = UIImage(data:data)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        lunch.dishImage = image
                        self.tableView.reloadRowsAtIndexPaths(
                            [indexPath], withRowAnimation: .None)
                    }
                    
                })
                
                
            }
            else{
               downloader.download(lunch.dishImageURL, completionHandler: { url in
                
                guard url != nil else {return}
                
                let data = NSData(contentsOfURL: url)!
                let image = UIImage(data:data)
                
                dispatch_async(dispatch_get_main_queue()) {
                    lunch.dishImage = image
                    self.tableView.reloadRowsAtIndexPaths(
                        [indexPath], withRowAnimation: .None)
                }
                
            })
            }
        }

        cell.selectionStyle = .None
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 282
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! CustomTableViewCell
        let gradientlayer = cell.imgFoodImage.layer.sublayers?.filter{$0.name == "gradientLayer"}.first!
        
        if cell.imgFoodImage.image == nil {
            gradientlayer!.hidden = true
        }
        else{
            gradientlayer!.hidden = false
        }
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "ChefSegue"{
            
            let destinationVC = segue.destinationViewController as! ChefScreenViewController
            let sender = sender as! UITapGestureRecognizer
            let selectedRow = sender.view!.tag
            let chefID = self.lunch[selectedRow].postedByID
            let chef = DataManager.sharedInstance.chefs.filter({ $0._id == chefID  })
            
            
            destinationVC.chef = chef.first
            
        }
        else if segue.identifier == "DishSegue"{
            
            let selectedRow = self.tableView.indexPathForSelectedRow!
            let selectedDish = lunch[selectedRow.row]
            let destinationVC = segue.destinationViewController as! DishScreenViewController
            destinationVC.dish = selectedDish
            destinationVC.initialQuantity = self.quantityArray[selectedRow.row]
            destinationVC.indexPathRow = selectedRow.row
            destinationVC.delegate = self
        }
        
        if segue.identifier == "RateChef" {
            
            let sender = sender as! UITapGestureRecognizer
            let selectedRow = sender.view!.tag
            let selectedDish = lunch[selectedRow]
            let destinationVC = segue.destinationViewController as! RateChefViewController
            destinationVC.dish = selectedDish
        }

        
    }
   

}
