//
//  BreakFastTableViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/4/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class BreakFastTableViewController: UITableViewController {
    
    
    var dishes = [Dish]()
    var chefs = [Chef]()
    
    func profileTapped(sender:UITapGestureRecognizer){
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.performSegueWithIdentifier("ChefSegue", sender: sender)
        }
        
        print("image tapped")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GET DISH
        RequestManager.request(.GET, baseURL: .getDish, parameterString: nil) { (jsonData) -> () in
           
            jsonData.forEach({ (dish: (String, JSON)) -> () in
              
                let dishJSON = dish.1
                
                let dishes = dishJSON["dishes"].arrayValue
                
                dishes.forEach({ (JSON) -> () in
                    
                    let id:String = JSON["_id"].stringValue
                    let name:String = JSON["name"].stringValue
                    let type:String = JSON["type"].stringValue
                    let category:String = JSON["category"].stringValue
                    let description:String = JSON["desc"].stringValue
                    let price:Double = JSON["price"].doubleValue
                    let imageURL:String = JSON["image_url"].stringValue
                    let postedByName:String = dishJSON["name"].stringValue
                    let postedByImageURL:String = dishJSON["profilepicture"].stringValue
                    let postedByID:String = dishJSON["_id"].stringValue
                    
                    let dish = Dish(id:id,name: name,type: type,category: category,description: description,price: price,postedByName: postedByName,postedByImageURL: postedByImageURL,postedByID: postedByID,dishImageURL:imageURL)
                    
                    self.dishes.append(dish)
                })
//
//                let id:String = dishJSON["_id"].stringValue
//                let name:String = dishJSON["name"].stringValue
//                let type:String = dishJSON["type"].stringValue
//                let category:String = dishJSON["category"].stringValue
//                let description:String = dishJSON["desc"].stringValue
//                let price:Double = dishJSON["price"].doubleValue
//                let postedByName:String = dishJSON["posted_by_name"].stringValue
//                let postedByImageURL:String = dishJSON["posted_by_image"].stringValue
//                let postedByID:String = dishJSON["posted_by_id"].stringValue
//
//                let dish = Dish(id:id,name: name,type: type,category: category,description: description,price: price,postedByName: postedByName,postedByImageURL: postedByImageURL,postedByID: postedByID,chefImage: nil)
//                
//                self.dishes.append(dish)
                
            })
            self.tableView.reloadData()
        }
        
        //GET CHEF
        RequestManager.request(.GET, baseURL: .getChef, parameterString: nil) { (jsonData) -> () in
            
            jsonData.forEach({ (chef:(String, JSON)) -> () in
                
                let chefJSON = chef.1
                
                 let _v:String = chefJSON["_v"].stringValue
                 let _id:String = chefJSON["_id"].stringValue
                 let dob:String = chefJSON["dob"].stringValue
                 let emailAddress:String = chefJSON["emailaddress"].stringValue
                 let name:String = chefJSON["name"].stringValue
                let password:String = chefJSON["password"].stringValue
                let longitude:Double = chefJSON["longitude"].doubleValue
                 let latitude:Double = chefJSON["latitude"].doubleValue
                 let profileCreateTimestamp:String = chefJSON["profileCreateTimestamp"].stringValue
                 let dishes:[JSON] = chefJSON["dishes"].arrayValue
                 let tags:[JSON] = chefJSON["tags"].arrayValue
                 let ratings:[JSON] = chefJSON["ratings"].arrayValue
                 let phones:[JSON] = chefJSON["phones"].arrayValue
                 let followers:[JSON] = chefJSON["followers"].arrayValue
                 let addresses:[JSON] = chefJSON["addresses"].arrayValue
                 let aboutme:String = chefJSON["aboutme"].stringValue
                 let googleplusid:String = chefJSON["aboutme"].stringValue
                 let fbid:String = chefJSON["googleplusid"].stringValue
                 let profilePictureURL:String = chefJSON["profilepicture"].stringValue
                 let gender:String = chefJSON["gender"].stringValue
                 let deviceId:String = chefJSON["deviceid"].stringValue
                 let deviceType:String = chefJSON["devicetype"].stringValue
                
                let chef = Chef(_v:_v,_id: _id,dob: dob,emailAddress: emailAddress,name: name,password: password,longitude: longitude,latitude: latitude,profileCreateTimestamp: profileCreateTimestamp,dishes: dishes,tags: tags,ratings: ratings,phones: phones,followers: followers,addresses: addresses,aboutme: aboutme,googleplusid: googleplusid,fbid: fbid,profilePictureURL: profilePictureURL,gender: gender,deviceId: deviceId,deviceType: deviceType)
                
                self.chefs.append(chef)
                
                
            })
            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return dishes.count
        return dishes.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BreakFastCell", forIndexPath: indexPath) as! CustomTableViewCell

        let dish = dishes[indexPath.row] as Dish
        
        cell.lblPrice.text = "₹"+String(dish.price)
        cell.lblFoodName.text = dish.name
        cell.lblDescription.text = dish.description
        cell.lblChefName.text = dish.postedByName
        
        let tap = UITapGestureRecognizer(target: self, action: "profileTapped:")
        cell.imgProfileImage.userInteractionEnabled = true
        cell.imgProfileImage.addGestureRecognizer(tap)
        cell.imgProfileImage.tag = indexPath.row
        
    
        if let chefImage = dish.postedByImage {
            cell.imgProfileImage.image = chefImage
            cell.imgProfileImage.contentMode = .ScaleAspectFill
        }
        else{
            cell.imgProfileImage.image = nil
            downloader.download(dish.postedByImageURL, completionHandler: { url in
                
                guard url != nil else {return}
                
                let data = NSData(contentsOfURL: url)!
                let image = UIImage(data:data)
                
                dispatch_async(dispatch_get_main_queue()) {
                    dish.postedByImage = image
                    self.tableView.reloadRowsAtIndexPaths(
                            [indexPath], withRowAnimation: .None)
                }
                
            })
        }
        
        if let foodImage = dish.dishImage{
            cell.imgFoodImage.image = foodImage
            cell.imgFoodImage.contentMode = .ScaleAspectFill
        }
        else{
            
            cell.imgFoodImage.image = nil
            downloader.download(dish.dishImageURL, completionHandler: { url in
            
            guard url != nil else {return}
            
            let data = NSData(contentsOfURL: url)!
            let image = UIImage(data:data)
            
            dispatch_async(dispatch_get_main_queue()) {
                dish.dishImage = image
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
        return 250.0
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
            let chefID = self.dishes[selectedRow].postedByID
            let chef = self.chefs.filter({ $0._id == chefID  })
            
    
            destinationVC.chef = chef.first
    
            print("segue finished")
        }
        else if segue.identifier == "DishSegue"{
    
            let selectedRow = self.tableView.indexPathForSelectedRow!
            let selectedDish = dishes[selectedRow.row]
            let destinationVC = segue.destinationViewController as! DishScreenViewController
            destinationVC.dish = selectedDish
        }
        
    }


}
