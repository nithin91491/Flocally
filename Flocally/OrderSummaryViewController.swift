//
//  OrderSummaryViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/25/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class OrderSummaryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var items : [[String:AnyObject]]!

    @IBOutlet weak var lblOrderAmount: UILabel!
    @IBOutlet weak var lblConvenienceFees: UILabel!
    
    @IBOutlet weak var lblTaxes: UILabel!
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    var orderedAmount:Double!
    
    let convenienceFees = 20.0
    let taxes = 15.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblOrderAmount.text = "₹\(orderedAmount)"
        self.lblConvenienceFees.text = "₹\(convenienceFees)"
        self.lblTaxes.text = "₹\(taxes)"
        self.lblTotalAmount.text = "₹\(convenienceFees+orderedAmount+taxes)"
        
        
        //Checkout:
        
        var chefIDs = ""
        var dishIDs = ""
        var servings = ""
        
        //Bulding a comma seperated string of ordered items to supply to API
        itemsToCheckout.forEach { item in
            
            chefIDs += "\(item["postedByID"]!),"
            dishIDs += "\(item["dishID"]!),"
            servings += "\(item["quantity"]!),"
            
        }
        
        chefIDs = String(chefIDs.characters.dropLast())   //Remove trailing comma
        dishIDs = String(dishIDs.characters.dropLast())
        servings = String(servings.characters.dropLast())
        
        
        RequestManager.postRequest(.updateServings, params: ["chefid":"\(chefIDs)","dishid":"\(dishIDs)","serving":"\(servings)"]) { (data) -> () in
            print(data)
        }
        
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named: "arrow-left")!, style: .Plain, target: self, action: #selector(OrderSummaryViewController.back(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton;
        
    }
    
    func back(sender: UIBarButtonItem) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK:- Table View
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("orderSummary", forIndexPath: indexPath) as! OrderSummaryCell
        
        let cartItemDictionary = self.items[indexPath.row]
        let dishName = cartItemDictionary["dishName"] as! String
        cell.lblDishName.text = dishName
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
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
