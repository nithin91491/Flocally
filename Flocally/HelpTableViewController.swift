//
//  HelpTableViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/25/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class HelpTableViewController: UITableViewController {

    var selectedIndexPath:NSIndexPath?
    var shouldExpand = true
    var previousSelectedIndexPath:NSIndexPath?
    
    var expanded = false
    var previousExpanded = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
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
        return 25
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HelpCell", forIndexPath: indexPath) as! HelpTableViewCell
        
        let question = cell.lblQuestion
        let answer = cell.lblAnswer

        if let selInd = selectedIndexPath{
            if selInd == indexPath && shouldExpand {
              
                answer.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat"
                cell.backgroundColor = UIColor.whiteColor()
                question.textColor = UIColor.redColor()
                
            }
        }
        
        if let _ = previousSelectedIndexPath{
            
            if !shouldExpand { //tap on expanded row--unexpand it
                answer.text = ""
                cell.backgroundColor = UIColor.redColor()
                question.textColor = UIColor.whiteColor()
                
            }
            
        }
        
        
        cell.selectionStyle = .None
        
        return cell
    }
   
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       selectedIndexPath = indexPath
       
        if let prev = previousSelectedIndexPath{
            
            if prev == indexPath{ //tap on same cell
                if previousExpanded{
                shouldExpand = false
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                expanded = false
                }
                else{
                    shouldExpand = true
                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    expanded = true
                }
            }
            else{// tap on other cell
                
                //expand the current cell
                shouldExpand = true
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                expanded = true
                
                if previousExpanded {
                //Unexpand previous selected cell if expanded previously
                shouldExpand = false
                self.tableView.reloadRowsAtIndexPaths([prev], withRowAnimation: .Automatic)
                }
            }
            
        }
        else{ //tap for the first time
            
            if !expanded{
            shouldExpand = true
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            
            expanded = true
        }
        
        previousExpanded = expanded
        previousSelectedIndexPath = selectedIndexPath
        
    }
  
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell1 = cell as! HelpTableViewCell

        if cell1.lblAnswer.text == ""{
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {cell1.imgArrow.transform = CGAffineTransformIdentity}, completion: nil)
            
        }
        else{
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {let transform = CGAffineTransformMakeRotation(-1.5708) // 90 degrees anti-clockwise
                cell1.imgArrow.transform = transform}, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
