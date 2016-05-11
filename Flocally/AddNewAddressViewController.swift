//
//  AddNewAddressViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 4/12/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class AddNewAddressViewController: UIViewController {
    
    var isEditMode = false
    var address:Address?
    let addressKey1 = "address1"
    
    @IBOutlet weak var txfAddressLine1: UITextField!
    
    @IBOutlet weak var txfAddressLine2: UITextField!
    
    @IBOutlet weak var txfCity: UITextField!
    
    @IBOutlet weak var txfState: UITextField!
    
    @IBOutlet weak var txfPinCode: UITextField!
    
    
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func continueAction(sender: UIButton) {
        
        
        let address1 = self.txfAddressLine1.text!
        let address2 = self.txfAddressLine2.text!
        let city = self.txfCity.text!
        let state = self.txfState.text!
        let pinCode = self.txfPinCode.text!
        
        guard address1 != "" && address2 != "" && city != "" && state != "" && pinCode != ""  else{return}
        
        
        if isEditMode { // update existing address
//            let address = Address(addressLine1: address1, addressLine2: address2, state: state, city: city, pinCode: pinCode, key: self.address!.key)
//            let addressData = NSKeyedArchiver.archivedDataWithRootObject(address)
//            NSUserDefaults.standardUserDefaults().setObject(addressData, forKey:self.address!.key )
            self.navigationController?.popViewControllerAnimated(true)
        }
        else{ // save new address

           let address = "\(address1),\(address2),\(city),\(pinCode),\(state),India"
            
            RequestManager.postRequest(.addUserAddress, params: ["id":userID,"type":"Home","address":address,"latitude":latitude,"longitude":longitude], block: { (data) -> () in
                print(data)
            })
            
            self.performSegueWithIdentifier("payment", sender: self)
        }
        
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        if let address = address{
           isEditMode = true
            self.txfAddressLine1.text = address.addressLine1
            self.txfAddressLine2.text = address.addressLine2
            self.txfCity.text = address.city
            self.txfPinCode.text = address.pinCode
            self.txfState.text = address.state
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
