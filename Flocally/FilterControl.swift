//
//  FilterControl.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 4/18/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit


class FilterControl: UIControl {

    var numberOfSections : Int
    var xPositionArray=[CGFloat]()
    var strokeWidth = 2
    var strokeColor = UIColor.whiteColor().CGColor
    var background = UIColor.redColor()
    let margin:CGFloat = 15
    var selectedIndex = 0
    var selectedItem = ""
    private var knobPosition:CGFloat = 0
    private var midPointBetweenSections:CGFloat = 0
    private let items:[String]
    
    init(frame:CGRect,numberOfSections:Int,items:[String]){
    
       self.numberOfSections = numberOfSections
        self.items = items
       super.init(frame: frame)
        setup()
    
    }

   required init?(coder aDecoder: NSCoder) {
       self.numberOfSections = 2
       self.items = [String]()
       super.init(coder: aDecoder)
        setup()
   }
    
    func setup(){
        
        knobPosition = margin
        selectedItem = items[0]
        let drawableWidth = frame.size.width-margin*2
    
        for i in 0..<numberOfSections{
            
            let x = knobPosition + (drawableWidth/CGFloat(numberOfSections-1)) * CGFloat(i)
            xPositionArray.append(x)
            let label = UILabel()
            label.text = items[i]
            label.font = label.font.fontWithSize(12)
            label.sizeToFit()
            label.textColor = UIColor.whiteColor()
            label.frame.origin.x = x-label.frame.width/2
            label.frame.origin.y = -2
            
            self.addSubview(label)
            
        }
        
        
        midPointBetweenSections = (drawableWidth/CGFloat(numberOfSections-1))/2
        
        
        self.backgroundColor = background
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context = UIGraphicsGetCurrentContext()
        let yCoordinate = rect.size.height-10
        
        self.backgroundColor = background
        
        CGContextSetLineWidth(context, CGFloat(strokeWidth))
        CGContextMoveToPoint(context, margin, yCoordinate)
        CGContextAddLineToPoint(context, frame.size.width - margin, yCoordinate)//Horizontal line
        
        for x in xPositionArray {
          CGContextMoveToPoint(context, x, yCoordinate)
          CGContextAddLineToPoint(context, x, yCoordinate-15)
        }
        
        CGContextSetStrokeColorWithColor(context, strokeColor)
        
        //Draw knob
        
        knobPosition = knobPosition < margin ? margin : knobPosition
        knobPosition = knobPosition > frame.size.width-margin ? frame.size.width-margin :knobPosition
        
        let rect = CGRectMake(knobPosition-5, yCoordinate-7, 10, 10)
        CGContextAddEllipseInRect(context, rect)
        
        CGContextStrokePath(context)
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextFillEllipseInRect(context, rect)
        
    }
    
    
    func updateKnobPosition(){
        if knobPosition > xPositionArray[selectedIndex]{
            let index = selectedIndex+1 >= xPositionArray.count ? xPositionArray.count-1 : selectedIndex + 1
            knobPosition = xPositionArray[index]
            selectedIndex = index
        }
        
        if knobPosition < xPositionArray[selectedIndex]{
            let index = selectedIndex-1 < 0 ? 0 : selectedIndex - 1
            knobPosition = xPositionArray[index]
            selectedIndex = index
        }
        setNeedsDisplay()
        
        selectedItem = items[selectedIndex]
        self.sendActionsForControlEvents(UIControlEvents.TouchDragExit)
    }
    
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        return true
        
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        
        knobPosition = touch.locationInView(self).x
        setNeedsDisplay()
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        updateKnobPosition()
    }
    
    override func cancelTrackingWithEvent(event: UIEvent?) {
        updateKnobPosition()
    }
}
