//
//  HitTestView.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/5/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class HitTestView: UIView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {      
        self.nextResponder()?.touchesBegan(touches, withEvent: event)
    }
    
}


class hitScroll:UIScrollView{
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.nextResponder()?.touchesBegan(touches, withEvent: event)
    }
    
}