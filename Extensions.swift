//
//  ImageViewExtension-Gradient.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/1/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import Foundation

extension UIImageView {
    
    func addBottomGradient(color: CGColorRef)  {
       let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        
        let color1 = UIColor.clearColor().CGColor as CGColorRef
        let color2 = color
        
        gradientLayer.colors = [color1,color2]
        gradientLayer.locations = [0.5,1]
        gradientLayer.name = "gradientLayer"
        
        gradientLayer.hidden = true
        self.layer.addSublayer(gradientLayer)
       
    }
}

extension UIView {
    
    @IBInspectable var borderColor : UIColor? {
        set (newValue) {
            self.layer.borderColor = (newValue ?? UIColor.clearColor()).CGColor
        }
        get {
            return UIColor(CGColor: self.layer.borderColor ?? UIColor.clearColor().CGColor)
        }
    }
}