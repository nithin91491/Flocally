//
//  RateChefViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/2/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class RateChefViewController: UIViewController,RatingViewDelegate,UITextViewDelegate {

    //MARK :- Properties and outlets
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var imgDish: UIImageView!
    
    @IBOutlet weak var lblChefName: UILabel!

    @IBOutlet weak var ratingView: RatingView!
    
    @IBOutlet weak var txfComments: UITextView!
    
    
    var dish:Dish!
    
    var starRating:CGFloat = 1
    
    
    
    
    
    @IBAction func submit(sender:UIButton){
        
        
        guard self.txfComments.text != "" && self.txfComments.text != "Leave Comments"  else {
            
            self.txfComments.layer.borderColor = UIColor.redColor().CGColor
            self.txfComments.layer.borderWidth = 0.5
            return}
        
        let param = "chefid=\(dish.postedByID)&userid=1234567&username=testuser2&userprofilepic=sample&dishid=\(dish.id)&point=\(starRating)&comment=\(txfComments.text)"
        
        
       RequestManager.request(.POST, baseURL: .addChefDishReview, parameterString: param) { (data) -> () in
        
        print(data)
        }
        
        
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
        print(dish.postedByID)
        
            if self.dish.dishImage != nil{
            self.imgDish.image = self.dish.dishImage
            self.imgDish.contentMode = .ScaleToFill
            }
            else{
                downloader.download(self.dish.dishImageURL) { url in
                    
                    guard url != nil else {return}
                    
                    let data = NSData(contentsOfURL: url)!
                    let image = UIImage(data:data)
                    
                    dispatch_async(dispatch_get_main_queue()){
                    self.imgDish.image = image
                    self.imgDish.contentMode = .ScaleToFill
                    }
                }
            }
        
        self.lblChefName.text = dish.postedByName
        
        self.ratingView.delegate = self
        
        self.txfComments.delegate = self
        
    }
        
       
    func keyBoardWillAppear(notification:NSNotification){
        
        let userInfo = notification.userInfo! as NSDictionary
        
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
    
    
    //MARK:- Rating view Delegate
    func ratingView(ratingView: RatingView, didChangeRating newRating: Float){
        starRating = CGFloat(newRating)
    }

    
    //MARK:- Textview delegate
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
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
