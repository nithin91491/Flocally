//
//  scrollViewTesting.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 3/4/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class scrollViewTesting: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillAppear:", name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }

    
    weak var activeField: UITextField?
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.activeField = nil
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeField = textField
    }
    
    func keyBoardWillAppear(notification:NSNotification){
        
        if let activeField = self.activeField, keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height+10, right: 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
//            if (!CGRectContainsPoint(aRect, activeField.frame.origin)) {
//                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
//            }
        }
    }
    
    func keyBoardWillDisappear(notification:NSNotification){
        self.scrollView.setContentOffset(CGPointZero, animated: true)
    }

}
