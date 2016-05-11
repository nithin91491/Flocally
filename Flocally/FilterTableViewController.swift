//
//  FilterTableViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 4/19/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    
    var items = [[String]]()
    var itemName = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Filters"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

       items.append(["Breakfast","Lunch","Snacks","Dinner"])
        //items.append(["Mild","Medium","Hot"])
        items.append(["Below ₹100","₹200-300","₹500 & Above"])
        //items.append(["Below 1Km", "1-2Kms","Above 3Kms"])
        items.append(["Vegetarian","Non-Vegetarian"])
        //items.append(["Now","15 mins", "30 mins"])
        //items.append(["Pickup Only","Delivery"])
        
        itemName.append("Sorting Options")
        //itemName.append("Spice Level")
        itemName.append("Price Range")
        //itemName.append("Distance Range")
        itemName.append("Veg/Non-Veg")
        //itemName.append("Availability")
        //itemName.append("Options")
        
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
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filterCell", forIndexPath: indexPath)

        let label = cell.viewWithTag(1) as! UILabel
        label.text = itemName[indexPath.row]
        label.textColor = UIColor.whiteColor()
       
        
        let filterView = cell.viewWithTag(2)! as UIView
        let rect = filterView.frame
        let filterRect = CGRectMake(0, 0, cell.frame.size.width-60, rect.height)
       
        let filterControl = FilterControl(frame:filterRect , numberOfSections: self.items[indexPath.row].count,items: self.items[indexPath.row])
        filterControl.tag = indexPath.row
        filterControl.addTarget(self, action: "selectedIndexChanged:", forControlEvents: .TouchDragExit)
        
        filterView.addSubview(filterControl)
//
        cell.backgroundColor = UIColor.redColor()
        
        cell.selectionStyle = .None

        return cell
    }
    
    func selectedIndexChanged(sender:FilterControl){
        print(sender.tag)
        //print(sender.selectedIndex)
        print(sender.selectedItem)
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
