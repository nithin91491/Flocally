//
//  ChoosePaymentViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/26/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class ChoosePaymentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var paymentMethods = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentMethods.append("Debit card/Credit card")
        paymentMethods.append("Cash on Delivery")
        paymentMethods.append("Pay U")
        paymentMethods.append("Freecharge")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("choosePaymentCell", forIndexPath: indexPath) as! ChoosePaymentCell
        cell.lblPaymentMethod.text = paymentMethods[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
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
