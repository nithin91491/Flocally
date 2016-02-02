//
//  PagingMenuOptions.swift
//  PagingMenuController
//
//  Created by Yusuke Kita on 5/17/15.
//  Copyright (c) 2015 kitasuke. All rights reserved.
//

import UIKit

public class PagingMenuOptions {
    public var defaultPage = 0
    public var scrollEnabled = true // in case of using swipable cells, set false
    public var backgroundColor = UIColor.redColor()
    public var selectedBackgroundColor = UIColor.redColor()
    public var textColor = UIColor(red: 254, green: 154, blue: 166, alpha: 0.8)
    public var selectedTextColor = UIColor.whiteColor()
    public var font = UIFont.systemFontOfSize(12)
    public var selectedFont = UIFont.systemFontOfSize(12)
    public var menuPosition: MenuPosition = .Top
    public var menuHeight: CGFloat = 50
    public var menuItemMargin: CGFloat = 20
    public var animationDuration: NSTimeInterval = 0.3
    public var deceleratingRate: CGFloat = UIScrollViewDecelerationRateNormal
    public var menuDisplayMode:MenuDisplayMode = MenuDisplayMode.SegmentedControl
    //MenuDisplayMode.Standard(widthMode: PagingMenuOptions.MenuItemWidthMode.Flexible, centerItem: false, scrollingMode: PagingMenuOptions.MenuScrollingMode.PagingEnabled)
    public var menuItemMode = MenuItemMode.Underline(height: 3, color: UIColor.whiteColor(), horizontalPadding: 0, verticalPadding: 0)
    internal var menuItemCount = 0
    internal let minumumSupportedViewCount = 1
    
    public enum MenuPosition {
        case Top
        case Bottom
    }
    
    public enum MenuScrollingMode {
        case ScrollEnabled
        case ScrollEnabledAndBouces
        case PagingEnabled
    }
    
    public enum MenuItemWidthMode {
        case Flexible
        case Fixed(width: CGFloat)
    }
    
    public enum MenuDisplayMode {
        case Standard(widthMode: MenuItemWidthMode, centerItem: Bool, scrollingMode: MenuScrollingMode)
        case SegmentedControl
        case Infinite(widthMode: MenuItemWidthMode)
    }
    
    public enum MenuItemMode {
        case None
        case Underline(height: CGFloat, color: UIColor, horizontalPadding: CGFloat, verticalPadding: CGFloat)
        case RoundRect(radius: CGFloat, horizontalPadding: CGFloat, verticalPadding: CGFloat, selectedColor: UIColor)
    }
    
    public init() {
        
    }
}