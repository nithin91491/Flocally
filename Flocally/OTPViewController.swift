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
        
        let parameter = "/\(phoneNumber)"
        
        RequestManager.request(.GET, baseURL: .generateOTP, parameterString: parameter) { (data) -> () in
            print(data)
        }
        
       // post(["mobile":phoneNumber], url: "http://flocally.com/api/sms.php")
        
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
        
        self.view.endEditing(true)
    }
    @IBAction func submitOTP(sender: UIButton) {
        
        guard self.txfOTP.text != "" && self.txfOTP.text?.characters.count == 6 else {return}
        

        RequestManager.postRequest(.validateOTP, params: ["token":"\(self.txfOTP.text!)"]){ (data) -> () in
            if data["message"].stringValue == "Verified."{
                
                //add new user
                
                RequestManager.postRequest(.addUser, params: ["phone":self.phoneNumber,"deviceid":deviceID,"devicetype":"iPhone"], block: { (data) -> () in
                    print(data)
                    
                    userID = (data["data"] as JSON)["_id"].stringValue
                    
                    NSUserDefaults.standardUserDefaults().setValue(userID, forKey: "userid")
                    
                    let alertController = UIAlertController(title: "Success", message: "You have registered successfully", preferredStyle: .Alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }))
                    self.presentViewController(alertController, animated: true,completion: nil)
                    
                    
                })
                
                
                
            }
            else{
                let alertController = UIAlertController(title: "Failure", message: data["message"].stringValue, preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        
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
    
    func post(params : Dictionary<String, String>, url : String) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        
        do{
            
            
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.init(rawValue: 0))
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
        }
            
        catch{
            
            print("Error writing JSON: ")
            
        }
        
        let task =  session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if error == nil{
                
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                print(strData)
                
            }
                
            else {
                
                
            }
            
        })
        
        
        
        task.resume()
        
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
