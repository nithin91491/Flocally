//
//  RateCustomerViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/2/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class RateCustomerViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var txfComments: UITextView!
    
    var starRating:CGFloat = 1
    
    @IBAction func submit(sender:UIButton){
        
        
        guard self.txfComments.text != "" && self.txfComments.text != "Leave Comments"  else {
        
        self.txfComments.layer.borderColor = UIColor.redColor().CGColor
        self.txfComments.layer.borderWidth = 1
        return
        }
//        let param = "chefid=\(dish.postedByID)&userid=1234567&username=testuser2&userprofilepic=sample&dishid=\(dish.id)&point=\(starRating)&comment=\(txfComments.text)"
        
        
//        RequestManager.request(.POST, baseURL: .addChefDishReview, parameterString: param) { (data) -> () in
//            
//            print(data)
//        }

        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txfComments.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillAppear:", name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }


    deinit{
        print("Deinit")
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }

    //MARK:- Textview delegate
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
        textView.layer.borderWidth = 0
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text == ""{
            textView.attributedText = NSAttributedString(string: "Leave Comments", attributes: [NSForegroundColorAttributeName:UIColor.lightGrayColor()])
        }
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
