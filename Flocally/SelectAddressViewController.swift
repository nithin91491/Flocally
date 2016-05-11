//
//  SelectAddressViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 3/1/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class SelectAddressViewController:UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var addressView1: AddressCard!
    
    @IBOutlet weak var addressView2: AddressCard!
    
    
    @IBOutlet weak var addressView2CenterXConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var txfAddressLine1: UITextField!
    
    @IBOutlet weak var txfAddressLine2: UITextField!
    
    @IBOutlet weak var txfCity: UITextField!
    
    @IBOutlet weak var txfState: UITextField!
    
    @IBOutlet weak var txfPin: UITextField!
    
    
    var address1:Address!
    var address2:Address!
//    let addressKey1 = "address1"
//    let addressKey2 = "address2"
    var savedAddresses  = [JSON]()
    var addressToEdit:Address!
    let layerName = "TopBorder"
    var addressToDeliver:Address!
    var selectedAddress:Address!
    
    func delAction(sender:UIButton){ //Event forwarded from Address card
        
        if sender.superview?.superview?.tag == 1 {
        
            RequestManager.postRequest(.removeUserAddress, params: ["id":userID,"addressid":address1.id], block: { (data) in
                print(data)
            })
            
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
        
        else {
            
            RequestManager.postRequest(.removeUserAddress, params: ["id":userID,"addressid":address2.id], block: { (data) in
                print(data)
            })
            
                UIView.animateWithDuration(0.2){
                    self.addressView2.alpha = 0
                }
        }
    }
    
    func editAction(sender:UIButton){ //Event forwarded from Address card
        if sender.superview?.superview?.tag == 1{
            addressToEdit = address1
        }
        else{
            addressToEdit = address2
        }
      self.performSegueWithIdentifier("editAddress", sender: self)
    }
    
    override func viewDidLoad() {
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(SelectAddressViewController.selectionChanged(_:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(SelectAddressViewController.selectionChanged(_:)))
        
        self.addressView1.addGestureRecognizer(tapGestureRecognizer1)
        self.addressView2.addGestureRecognizer(tapGestureRecognizer2)
        
        //let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if savedAddresses.count > 1 {
           
            
            let layer1 = addressView1.layer
            
            layer1.shadowColor = UIColor.blackColor().CGColor
            layer1.shadowOffset = CGSize(width: 0, height: 5)
            layer1.shadowOpacity = 0.5
            layer1.shadowRadius = 8
            
            let borderLayer = CALayer()
            borderLayer.name = layerName
            borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.addressView1.frame), 5)
            borderLayer.backgroundColor = UIColor(red: 19/255, green: 147/255, blue: 42/255, alpha: 1).CGColor
            addressView1.layer.addSublayer(borderLayer)
            
            let layer2 = addressView2.layer
            
            layer2.shadowColor = UIColor.blackColor().CGColor
            layer2.shadowOffset = CGSize(width: 0, height: 5)
            layer2.shadowOpacity = 0.5
            layer2.shadowRadius = 8
            
            
//            let savedAddressData = NSUserDefaults.standardUserDefaults().objectForKey(addressKey1) as! NSData
//            address1 = NSKeyedUnarchiver.unarchiveObjectWithData(savedAddressData) as! Address
            
            address1 =  Address(address:savedAddresses[0]["address"].stringValue, id:savedAddresses[0]["_id"].stringValue)
         
            
            
            addressView1.lblName.text = userName
            addressView1.lblAddressLine1.text = address1.addressLine1
            addressView1.lblAddressLine2.text = address1.addressLine2
            addressView1.lblCityState.text = "\(address1.city),\(address1.state)"
            addressView1.lblPIN.text = address1.pinCode
            addressView1.lblMobileNumber.text = userPhoneNumber
            
            
             address2 = Address(address:savedAddresses[1]["address"].stringValue,id:savedAddresses[1]["_id"].stringValue)
            
            addressView2.lblName.text = userName
            addressView2.lblAddressLine1.text = address2.addressLine1
            addressView2.lblAddressLine2.text = address2.addressLine2
            addressView2.lblCityState.text = "\(address2.city),\(address2.state)"
            addressView2.lblPIN.text = address2.pinCode
            addressView2.lblMobileNumber.text = userPhoneNumber

            selectedAddress = address1
        }
        else{
        
         address1 =  Address(address:savedAddresses[0]["address"].stringValue,id:savedAddresses[0]["_id"].stringValue)
            
        addressView1.lblName.text = "UserName"
        addressView1.lblAddressLine1.text = address1.addressLine1
        addressView1.lblAddressLine2.text = address1.addressLine2
        addressView1.lblCityState.text = "\(address1.city),\(address1.state)"
        addressView1.lblPIN.text = address1.pinCode
        addressView1.lblMobileNumber.text = userPhoneNumber
            
            let layer1 = addressView1.layer
            
            layer1.shadowColor = UIColor.blackColor().CGColor
            layer1.shadowOffset = CGSize(width: 0, height: 5)
            layer1.shadowOpacity = 0.5
            layer1.shadowRadius = 8
            
            let borderLayer = CALayer()
            borderLayer.name = layerName
            borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.addressView1.frame), 5)
            borderLayer.backgroundColor = UIColor(red: 19/255, green: 147/255, blue: 42/255, alpha: 1).CGColor
            addressView1.layer.addSublayer(borderLayer)
            
            let layer2 = addressView2.layer
            
            layer2.shadowColor = UIColor.blackColor().CGColor
            layer2.shadowOffset = CGSize(width: 0, height: 5)
            layer2.shadowOpacity = 0.5
            layer2.shadowRadius = 8
            
            
            addressView2.hidden = true
            selectedAddress = address1
        }
        
    }
    
    func selectionChanged(sender:UITapGestureRecognizer){
        if sender.view?.tag == 1 {
            
            let borderLayer = CALayer()
            borderLayer.name = layerName
            borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.addressView1.frame), 5)
            borderLayer.backgroundColor = UIColor(red: 19/255, green: 147/255, blue: 42/255, alpha: 1).CGColor
            addressView1.layer.addSublayer(borderLayer)
            
            let layers =  addressView2.layer.sublayers?.filter({ (layer:CALayer) -> Bool in
                layer.name == self.layerName
            })
            
            layers?.forEach({ layer in
                layer.removeFromSuperlayer()
            })
            selectedAddress = address1
            
        }
        else{
            let borderLayer = CALayer()
            borderLayer.name = layerName
            borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.addressView2.frame), 5)
            borderLayer.backgroundColor = UIColor(red: 19/255, green: 147/255, blue: 42/255, alpha: 1).CGColor
            addressView2.layer.addSublayer(borderLayer)
            
            let layers =  addressView1.layer.sublayers?.filter({ (layer:CALayer) -> Bool in
                layer.name == self.layerName
                })
            layers?.forEach({ layer in
                layer.removeFromSuperlayer()
            })
            
            selectedAddress = address2
        }
    }
    
    func saveNewAddress() -> Bool{
        
        let address1 = self.txfAddressLine1.text!
        let address2 = self.txfAddressLine2.text!
        let city = self.txfCity.text!
        let state = self.txfState.text!
        let pinCode = self.txfPin.text!
        
        guard address1 != "" && address2 != "" && city != "" && state != "" && pinCode != ""  else{return false}
        
        let address = "\(address1),\(address2),\(city),\(pinCode),\(state),India"
        
        RequestManager.postRequest(.addUserAddress, params: ["id":userID,"type":"Home","address":address,"latitude":latitude,"longitude":longitude], block: { (data) -> () in
            print(data)
            
        })
        
        addressToDeliver = Address(address: address)
        addressView2.hidden = false
        return true
      
    }
    
    //Textfield Delegate methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editAddress"{
            let destinationVC = segue.destinationViewController as! AddNewAddressViewController
            destinationVC.address = self.addressToEdit
        }
        if segue.identifier == "proceedToPayment"{
            
            if !saveNewAddress(){
                addressToDeliver = selectedAddress
            }
            
        }
    }
    
}