//
//  FooterViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/1/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class FooterViewController: UIViewController {

    
    @IBOutlet weak var containerView: UIView!
    var navController:UINavigationController!
     @IBOutlet weak var menuButton : UIButton!
    
    
    @IBAction func homeAction(sender: UIButton) {
      
        self.navController?.popToRootViewControllerAnimated(true)
    }
    
    
    @IBAction func cartAction(sender: UIButton) {
       NSNotificationCenter.defaultCenter().postNotificationName("pushCartScreen", object: nil)
    }
    
    //MARK :- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FooterViewController.menuSelected(_:)), name: "menuSelected", object: nil) //Notification posted after selecting a particular menu item
        
        if self.revealViewController() != nil {
            menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), forControlEvents: .TouchUpInside)
            
            //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
       
        
    }

    deinit{
       NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func menuSelected(notification:NSNotification){
        
        let userInfo = notification.userInfo as! [String:AnyObject]
        let selectedMenu = userInfo["menuItem"] as! String
        
        var VC:UIViewController!
        
        switch(selectedMenu){
            case "Help":  VC =  self.storyboard?.instantiateViewControllerWithIdentifier("Help") as! HelpTableViewController
        case "AboutUs" :  VC =  self.storyboard?.instantiateViewControllerWithIdentifier("AboutUs")
        default:break
        }
        
        
        self.navController.pushViewController(VC, animated: false)
        self.menuButton.sendActionsForControlEvents(.TouchUpInside)//To close the Menu
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //MARK :- Functions
//    func totalAmountChanged(notification:NSNotification){
//        let userInfo = notification.userInfo! as! [String:AnyObject]
//        let totalAmount = userInfo["totalAmount"] as! Double
//        let shouldAdd = userInfo["shouldAdd"] as! Bool
//        let totalAmountOld = Double(lblTotalAmount.text!.stringByReplacingOccurrencesOfString("₹", withString: ""))!
//        self.lblTotalAmount.text = "₹\(shouldAdd ? totalAmountOld+totalAmount : totalAmountOld-totalAmount)"
//    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if segue.identifier == "NavEmbedd"{
      let destin =  segue.destinationViewController as! UINavigationController
        navController = destin
        }
    }
    

}
