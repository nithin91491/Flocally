//
//  RateCustomerViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/2/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class RateCustomerViewController: UIViewController {

    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBAction func submit(sender:UIButton){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillAppear:", name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }

    deinit{
        print("Deinit")
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
