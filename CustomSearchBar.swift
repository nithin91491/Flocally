//
//  CustomSearchBar.swift
//  CustomSearchBar
//
//  Created by Gabriel Theodoropoulos on 8/9/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit


//extension UISearchBarDelegate{
//    
//    public func textDidClear(searchField:UITextField)->Bool{
//      return false
//    }
//    
//}

class CustomSearchBar: UISearchBar {

    var preferredFont: UIFont!
    
    var preferredTextColor: UIColor!
    
    //var customDelegate:CustomSearchController!
    
    

    override func drawRect(rect: CGRect) {
        // Find the index of the search field in the search bar subviews.
        if let index = indexOfSearchFieldInSubviews() {
           
           let searchField = (subviews[0] ).subviews[index] as! UITextField
            
            // Customize search Field.
            searchField.frame = CGRectMake(0.0, 0.0, frame.size.width , frame.size.height)
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            searchField.attributedPlaceholder = NSAttributedString(string:" Search your meal..", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
            
        }
        
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
