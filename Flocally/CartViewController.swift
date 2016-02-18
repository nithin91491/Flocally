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
    var total:Double = 0.0
    let convenienceFee = 20.0
    let taxes = 15.0
    
    @IBOutlet weak var tableView:UITableView!
    //MARK:- View Life cycle
    
    @IBAction func orderMore(sender:UIButton){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        total = items.reduce(0.0, combine: { (T:Double, object) -> Double in
           T + ((object["price"] as! Double) * Double(object["quantity"] as! Int))
        })
        
        total += convenienceFee + taxes
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "quantityChanged:", name: "quantityChanged", object: nil) //Posted by- Cart tableview cell
    }

    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK:- Functions
    func quantityChanged(notification:NSNotification){
        let userInfo = notification.userInfo as! [String:AnyObject]
        let amount = userInfo["amount"] as! Double
        total += amount
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: items.count + 2, inSection: 0)], withRowAnimation: .None)
    }
    
    
    //MARK:- Table view 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0{
            return 0
        }
        else{
            return (items.count)+3
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("cartCell", forIndexPath: indexPath) as! CartTableViewCell
        
        if indexPath.row < items.count{
        cell.lblDishName.text = items[indexPath.row]["dishName"] as? String
        cell.lblQuantity.text = String(items[indexPath.row]["quantity"] as! Int)
        cell.lblPrice.text = "₹"+String(items[indexPath.row]["price"] as! Double)
        cell.initialQuantity = items[indexPath.row]["quantity"] as! Int
        }
        else{
            cell.lblQuantity.hidden = true
            cell.btnMinus.hidden = true
            cell.btnPlus.hidden = true
            
            switch (indexPath.row){
            case items.count  :  cell.lblDishName.text = "Convenience Fees"
                                    cell.lblPrice.text = "₹\(convenienceFee)"
                
            case items.count + 1:   cell.lblDishName.text = "Taxes"
                                    cell.lblPrice.text = "₹\(taxes)"
                
            case items.count + 2:    cell.lblDishName.text = "Total"
                                     cell.lblPrice.text = "₹\(total)"
                                     cell.lblDishName.textColor = UIColor.redColor()
                                     cell.lblPrice.textColor = UIColor.redColor()
            default: break
            }
            
            
        }
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
