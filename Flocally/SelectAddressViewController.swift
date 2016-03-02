//
//  SelectAddressViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 3/1/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class SelectAddressViewController:UIViewController{
    
    @IBOutlet weak var addressView1: AddressCard!
    
    @IBOutlet weak var addressView2: AddressCard!
    
    
    @IBOutlet weak var addressView2CenterXConstraint: NSLayoutConstraint!
    
    
    @IBAction func delAction(sender: UIButton) {
        
        UIView.animateWithDuration(0.2){
            self.addressView1.alpha = 0
        }
        
        self.addressView2.removeConstraint(self.addressView2CenterXConstraint)
        
        let xCenterConstraint = NSLayoutConstraint(item: self.addressView2, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 0.5, constant: 0)
         self.view.addConstraint(xCenterConstraint)
        
        UIView.animateWithDuration(0.5){
          self.view.layoutIfNeeded()
        }
        
    }
    
    override func viewDidLoad() {
        
        
//        addressView1.layer.borderWidth = 1
//        addressView1.layer.borderColor = UIColor.grayColor().CGColor
//        
//        addressView2.layer.borderWidth = 1
//        addressView2.layer.borderColor = UIColor.grayColor().CGColor
//        
        let layer1 = addressView1.layer
        
        layer1.shadowColor = UIColor.blackColor().CGColor
        layer1.shadowOffset = CGSize(width: 0, height: 5)
        layer1.shadowOpacity = 0.5
        layer1.shadowRadius = 8
        
        let borderLayer = CALayer()
        
        borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.addressView1.frame), 5)
        borderLayer.backgroundColor = UIColor(red: 19/255, green: 147/255, blue: 42/255, alpha: 1).CGColor
        addressView1.layer.addSublayer(borderLayer)
        
        let layer2 = addressView2.layer
        
        layer2.shadowColor = UIColor.blackColor().CGColor
        layer2.shadowOffset = CGSize(width: 0, height: 5)
        layer2.shadowOpacity = 0.5
        layer2.shadowRadius = 8

        
        
//        let card = AddressCard(frame:CGRectMake(0, 0, 250 , 200) )
//        card.frame.size = addressView1.frame.size
//        print(card.frame.size)
//        print(addressView1.frame.size)
//        card.lblAddressLine1.text = "Sample address1"
//        card.lblAddressLine2.text = "sample 2"
//        card.lblCityState.text = "Bangalore, karnataka"
//        card.lblMobileNumber.text = "9176657947"
//        self.addressView1.addSubview(card)
//        //card.clipsToBounds = true
//        card.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
//        card.sizeToFit()
//        card.layer.borderWidth = 1
//        card.layer.borderColor = UIColor.grayColor().CGColor
//        
//        //self.addressView1.clipsToBounds = true
//        
//        let card2 = AddressCard(frame:CGRectMake(0, 0, 250 , 200) )
//        card2.frame.size = addressView1.frame.size
//        
//        card2.lblAddressLine1.text = "Sample address2"
//        card2.lblAddressLine2.text = "sample 2"
//        card2.lblCityState.text = "Bangalore, karnataka"
//        card2.lblMobileNumber.text = "9176657947"
//        self.addressView2.addSubview(card2)
//        //card.clipsToBounds = true
//        card2.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
//        card2.sizeToFit()
//        card2.layer.borderWidth = 1
//        card2.layer.borderColor = UIColor.grayColor().CGColor
        
    }
    
    
}