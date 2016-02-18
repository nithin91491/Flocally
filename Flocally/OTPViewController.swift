//
//  OTPViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/18/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {
    
    
    @IBOutlet weak var phoneNumberView: UIView!
    
    @IBOutlet weak var txfPhoneNumber: UITextField!
    
    @IBOutlet weak var txfOTP: UITextField!
    
    
    var phoneNumber:String!
    var OTP = 123456
    
    @IBAction func submitPhoneNumber(sender: UIButton) {
        
        guard (self.txfPhoneNumber.text != "" || self.txfPhoneNumber.text != nil) && self.txfPhoneNumber.text?.characters.count == 10   else{return}
        
        phoneNumber = self.txfPhoneNumber.text
        
        let parameter = "mobile:\(phoneNumber)&msg:\(OTP)"
        
        RequestManager.request(.POST, baseURL: .postSMS, parameterString: parameter) { (data) -> () in
            print(data)
        }
        
        
        UIView.animateWithDuration(1, animations: {
            
            self.phoneNumberView.alpha = 0
            //self.phoneNumberView.hidden = true
            }, completion: { _ in
        
                for view in self.view.subviews{
                    if view.tag == 0{
                        UIView.animateWithDuration(0.5){
                            view.alpha = 1
                            view.hidden = false
                        }
                    }
                }
        
        })
        
        
    }
    @IBAction func submitOTP(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func resendOTP(sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()


        for view in self.view.subviews{
            if view.tag == 0{
                view.alpha = 0
                view.hidden = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
