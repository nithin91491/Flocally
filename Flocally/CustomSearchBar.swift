//
//  CustomSearchBar.swift
//  CustomSearchBar
//
//  Created by Gabriel Theodoropoulos on 8/9/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit


extension UISearchBarDelegate{
    
    public func textDidClear(searchField:UITextField)->Bool{
      return false
    }
    
}

class CustomSearchBar: UISearchBar,UITextFieldDelegate {

    var preferredFont: UIFont!
    
    var preferredTextColor: UIColor!
    
   // var customDelegate:CustomSearchController!
    
    

    override func drawRect(rect: CGRect) {
        // Drawing code
        
        // Find the index of the search field in the search bar subviews.
        if let index = indexOfSearchFieldInSubviews() {
            // Access the search field
           let searchField = (subviews[0] ).subviews[index] as! UITextField
            
            // Set its frame.
            searchField.frame = CGRectMake(0.0, 0.0, frame.size.width , frame.size.height)
            
            // Set the font and text color of the search field.
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            
            // Set the background color of the search field.
            searchField.backgroundColor = UIColor.clearColor()
            searchField.layer.cornerRadius = 14
        }
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = 13
        self.clipsToBounds = true
        
        super.drawRect(rect)
    }
    

    
    init(frame: CGRect, font: UIFont, textColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        preferredFont = font
        preferredTextColor = textColor
        
        searchBarStyle = UISearchBarStyle.Minimal
        translucent = true
        //self.delegate = self.customDelegate
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func indexOfSearchFieldInSubviews() -> Int! {
        
        var index: Int!
        let searchBarView = subviews[0] 
        
        for var i=0; i<searchBarView.subviews.count; ++i {
            if searchBarView.subviews[i].isKindOfClass(UITextField) {
                index = i
                break
            }
        }
        
        return index
    }
    
    //MARK: - Text field delegate function
//    func textFieldShouldClear(textField: UITextField) -> Bool {
//       return self.customDelegate.textDidClear(textField)
//    }
    
}
