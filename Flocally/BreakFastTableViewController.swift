//
//  BreakFastTableViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/4/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit



class BreakFastTableViewController: UITableViewController,updateUserSelectedQuantity {
    
    //MARK:- Properties and Outlets
     var breakfast=[Dish]()
     //var chefs=[Chef]()
    var quantityArray = [Int]()
    
    //var rateChefVC:RateChefViewController!
    
    
    //MARK:- IBActions
    
       

    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.sharedInstance.ifDishAvailable { [unowned self] in
            self.breakfast = DataManager.sharedInstance.dishes.filter{$0.type == "Breakfast"}
            
            for _ in 1...self.breakfast.count{
                self.quantityArray.append(0)
            }
           
            self.tableView.reloadData()
            
            //For early loading of dish images
            for (index,breakfast) in self.breakfast.enumerate(){
                
                if breakfast.dishImageURL == "" && breakfast.dishImageURLArray.count > 0 {
                    let imageURL = breakfast.dishImageURLArray[0]["image_url"].stringValue
                    
                    
                    downloader.download(imageURL, completionHandler: { url in
                        
                        guard url != nil else {return}
                        
                        let data = NSData(contentsOfURL: url)!
                        let image = UIImage(data:data)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            breakfast.dishImage = image
                            self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .None)
                        }
                        
                    })
                    
                    
                }
                else{
                    
                    
                    downloader.download(breakfast.dishImageURL, completionHandler: { url in
                        
                        guard url != nil else {return}
                        
                        let data = NSData(contentsOfURL: url)!
                        let image = UIImage(data:data)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            breakfast.dishImage = image
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
        
        cell.dishID = breakfast.id
        cell.lblPrice.text = "₹"+String(breakfast.price)
        cell.lblFoodName.text = breakfast.name
        cell.lblDescription.text = breakfast.description
        cell.lblChefName.text = breakfast.postedByName
        
        cell.btnPlus.tag = indexPath.row + 1 
        cell.btnMinus.tag = -(indexPath.row+1)
        cell.breakfastVC = self
        cell.lblQuantity.text = "\(quantityArray[indexPath.row])"
        
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
            
            
            cell.imgFoodImage.image = UIImage(named: "dummy-image")
            
            if breakfast.dishImageURL == "" && breakfast.dishImageURLArray.count > 0 {
              let imageURL = breakfast.dishImageURLArray[0]["image_url"].stringValue
               
                downloader.download(imageURL, completionHandler: { url in
                    
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
            else{
                
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
        
        
    }
        cell.selectionStyle = .None
        return cell
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 282.0
    }

//    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = cell as! CustomTableViewCell
//        let gradientlayer = cell.imgFoodImage.layer.sublayers?.filter{$0.name == "gradientLayer"}.first!
//        
//        if cell.imgFoodImage.image == nil {
//           gradientlayer!.hidden = true
//        }
//        else{
//            gradientlayer!.hidden = false
//        }
//    }
    
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
            let chef = DataManager.sharedInstance.chefs.filter({ $0._id == chefID  })
            
    
            destinationVC.chef = chef.first
    
        }
        else if segue.identifier == "DishSegue"{
    
            let selectedRow = self.tableView.indexPathForSelectedRow!
            let selectedDish = breakfast[selectedRow.row]
            let destinationVC = segue.destinationViewController as! DishScreenViewController
            destinationVC.dish = selectedDish
            destinationVC.initialQuantity = self.quantityArray[selectedRow.row]
            destinationVC.indexPathRow = selectedRow.row
            destinationVC.delegate = self
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
