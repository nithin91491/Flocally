//
//  BreakFastTableViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/4/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class BreakFastTableViewController: UITableViewController {
    
    let downloader = Downloader(configuration: NSURLSession.sharedSession().configuration)
    var dishes = [Dish]()

    
   // var container:UIView!
    
    
    func profileTapped(sender:UITapGestureRecognizer){
        self.performSegueWithIdentifier("ChefSegue", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RequestManager.request(.GET, baseURL: .getDish, parameterString: nil) { (jsonData) -> () in
           
            jsonData[0].forEach({ (dish: (String, JSON)) -> () in
              
                let dishJSON = dish.1
                
                let id:String = dishJSON["_id"].stringValue
                let name:String = dishJSON["name"].stringValue
                let type:String = dishJSON["type"].stringValue
                let category:String = dishJSON["category"].stringValue
                let description:String = dishJSON["desc"].stringValue
                let price:Double = dishJSON["price"].doubleValue
                let postedByName:String = dishJSON["posted_by_name"].stringValue
                let postedByImageURL:String = dishJSON["posted_by_image"].stringValue
                let postedByID:String = dishJSON["posted_by_id"].stringValue
                
                let dish = Dish(id:id,name: name,type: type,category: category,description: description,price: price,postedByName: postedByName,postedByImageURL: postedByImageURL,postedByID: postedByID,chefImage: nil)
                
                self.dishes.append(dish)
                
            })
            self.tableView.reloadData()
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
        return dishes.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BreakFastCell", forIndexPath: indexPath) as! CustomTableViewCell

        var dish = dishes[indexPath.row] as Dish
        
        cell.lblPrice.text = "₹"+String(dish.price)
        cell.lblFoodName.text = dish.name
        cell.lblDescription.text = dish.description
        cell.lblChefName.text = dish.postedByName
        
        let tap = UITapGestureRecognizer(target: self, action: "profileTapped:")
        
        cell.imgProfileImage.userInteractionEnabled = true
        cell.imgProfileImage.addGestureRecognizer(tap)
        
        let imageURL = "http://7-themes.com/data_images/out/50/6940479-beautiful-tulips-field.jpg"
        //"http://3.bp.blogspot.com/-oOHbx0vHUIM/UJrkKQZrnxI/AAAAAAAAJD0/2eDUdnnAM-0/s1600/smileyface.gif"//dish.postedByImageURL
        
        
    
        if let im = dish.chefImage {
            cell.imgProfileImage.image = im
            print(" image")
        } else {
            
            print("no image")
            
            
            let session = NSURLSession.sharedSession()
            let url = NSURL(string: imageURL)!
            let request = NSMutableURLRequest(URL: url)
            
            
            let task = session.downloadTaskWithURL(url) {
                    (loc:NSURL?, response:NSURLResponse?, error:NSError?) in
                    if error != nil {
                    print(error)
                    return }
                    let status = (response as! NSHTTPURLResponse).statusCode
                    if status != 200 {
                    print("response status: \(status)")
                    return }
                    let d = NSData(contentsOfURL:loc!)!
                    let im = UIImage(data:d)
                    dispatch_async(dispatch_get_main_queue()) {
                    dish.chefImage = im
                dispatch_async(dispatch_get_main_queue()) {
                cell.imgProfileImage.image = im
//                self.tableView.reloadRowsAtIndexPaths(
//                [indexPath], withRowAnimation: .None)
                }
                    }
            }
            task.resume()

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
