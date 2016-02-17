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
    
    
    //MARK :- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "totalAmountChanged:", name: "QuantityChanged", object: nil)
        
        
       
        
    }

//    deinit{
//       NSNotificationCenter.defaultCenter().removeObserver(self)
//    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
