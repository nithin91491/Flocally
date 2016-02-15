//
//  CartViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/15/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    var items:[[String:AnyObject]]!
    
    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    //MARK:- Table view 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("cartCell", forIndexPath: indexPath) as! CartTableViewCell
        cell.lblDishName.text = items[indexPath.row]["dishName"] as? String
        cell.lblQuantity.text = items[indexPath.row]["quantity"] as? String
        cell.lblPrice.text = items[indexPath.row]["price"] as? String
        return cell
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
