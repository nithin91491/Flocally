//
//  RateChefViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/2/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class RateChefViewController: UIViewController {

    //MARK :- Properties and outlets
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBAction func submit(sender:UIButton){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    //MARK :- View life cycle
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillAppear:", name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    
    func keyBoardWillAppear(notification:NSNotification){
        
        let userInfo = notification.userInfo as! NSDictionary
        
        let keyboardSize = userInfo.objectForKey("UIKeyboardFrameBeginUserInfoKey")!.CGRectValue.size
        
        let buttonOrigin = self.btnSubmit.frame.origin
        
        let buttonHeight = self.btnSubmit.frame.height
        
        var visiblerect = self.contentView.frame
        
        visiblerect.size.height -= keyboardSize.height+35
        
        if !CGRectContainsPoint(visiblerect, buttonOrigin) {
            let scrollpoint = CGPointMake(0.0, buttonOrigin.y - visiblerect.size.height + buttonHeight)
            
            self.scrollView.setContentOffset(scrollpoint, animated: true)
        }
    }
    
    func keyBoardWillDisappear(notification:NSNotification){
        self.scrollView.setContentOffset(CGPointZero, animated: true)
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
