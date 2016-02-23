//
//  ViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/4/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit
//import PagingMenuController

class ViewController: UIViewController,PagingMenuControllerDelegate{

    var leftSearchBarButtonItem: UIBarButtonItem?
    var rightSearchBarButtonItem: UIBarButtonItem?
    var searcher:UISearchController!
    var src:SearchResultsController!
    
    var cartItems = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.sharedInstance.downloadDishes{ }
        DataManager.sharedInstance.downloadChefs{ }
        
        setupPagingViewControllers()
        setupNavigationController()
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "cartItemChanged:", name: "cartItemChanged", object: nil) //Posted by-Custom tableview cell
        
        
    }
    
    
    func cartItemChanged(notification:NSNotification){
        
        let userInfo = notification.userInfo as! [String:AnyObject]
        
        let dishID = userInfo["dishID"] as! String
        let quantity = userInfo["quantity"] as! Int
        
        if  (cartItems.filter{ $0["dishID"] as! String == dishID }.count) > 0 { //Already exists
           
            if quantity > 0 {//Update the quantity
                let index = cartItems.indexOf({$0["dishID"] as! String == dishID})
                cartItems.removeAtIndex(index!)
                cartItems.insert(userInfo, atIndex: index!)
            }
            else{//Remove the item
                let index = cartItems.indexOf({$0["dishID"] as! String == dishID})
                cartItems.removeAtIndex(index!)
            }
                
        }
        else{//Add New Item
            cartItems.append(userInfo)
        }
        
       let cartButton = self.navigationItem.rightBarButtonItem as! BBBadgeBarButtonItem
        cartButton.badgeValue = "\(self.cartItems.count)"
        
    }
    
    func setupPagingViewControllers(){
        
        let breakFast = self.storyboard?.instantiateViewControllerWithIdentifier("BreakFast") as! BreakFastTableViewController
        breakFast.title = "  BREAKFAST"
    
        
        let lunch = self.storyboard?.instantiateViewControllerWithIdentifier("Lunch") as! LunchTableViewController
        lunch.title = "LUNCH"
        let dinner = self.storyboard?.instantiateViewControllerWithIdentifier("Dinner") as! DinnerTableViewController
        dinner.title = "DINNER"
        
        let snacks = self.storyboard?.instantiateViewControllerWithIdentifier("Snacks") as! SnacksTableViewController
        snacks.title = "SNACKS"
        
        let viewControllers = [breakFast,lunch,snacks,dinner]
        
        let options = PagingMenuOptions()
        options.menuHeight = 35
        options.selectedTextColor = UIColor.whiteColor()
        options.backgroundColor = UIColor.redColor()
        options.selectedBackgroundColor = UIColor.redColor()
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        
        
        //set tab based on current time.
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([ .Hour, .Minute, .Second], fromDate: date)
        let hour = components.hour
        
        switch (hour){
        case 0..<11 : pagingMenuController.moveToMenuPage(0, animated: true) //Breakfast
        case 11..<15: pagingMenuController.moveToMenuPage(1, animated: true) //Lunch
        case 15..<19: pagingMenuController.moveToMenuPage(2, animated: true) //Snacks
        case 19..<24: pagingMenuController.moveToMenuPage(3, animated: true) //Dinner
        default :pagingMenuController.moveToMenuPage(0, animated: true) //Breakfast
        }
        
        
    }
    
    func setupNavigationController(){
        
        let searchResultsController = SearchResultsController()
        searchResultsController.navigation = self.navigationController
        src = searchResultsController
        let frame = CGRectMake(0, 0, (self.navigationController?.navigationBar.frame.size.width)!, 30.0)
        
        self.searcher = UISearchController(searchResultsController: src)
        
        searcher.searchBar.setSearchFieldBackgroundImage(UIImage(named: "searchBG"), forState: .Normal)
        searcher.searchBar.searchBarStyle = .Minimal
        
        searcher.hidesNavigationBarDuringPresentation = false
        searcher.searchBar.showsCancelButton = false
        searcher.searchResultsUpdater = src
        searcher.searchBar.tintColor = UIColor.whiteColor()
        searcher.searchBar.setImage(UIImage(named: "SearchIcon")!, forSearchBarIcon: .Search, state: .Normal)
    
        let placeholder = NSAttributedString(string:" Search your meal..", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        if #available(iOS 9.0, *) {
            UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).attributedPlaceholder = placeholder
            UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).textColor = UIColor.whiteColor()
        } else {
           
            for subview in searcher.searchBar.subviews[0].subviews {
                if subview.isKindOfClass(UITextField) {
                    let textfield = subview as! UITextField
                    textfield.attributedPlaceholder = placeholder
                    textfield.textColor = UIColor.whiteColor()
                }
            }
            
        }
        
    
        let titleViewCustom = UIView(frame:frame)
        titleViewCustom.addSubview(searcher.searchBar)

        titleViewCustom.backgroundColor = UIColor.clearColor()
        
        //searcher.searchBar.searchFieldBackgroundPositionAdjustment = UIOffsetMake(0, 8)
        self.navigationItem.titleView = titleViewCustom
        //self.navigationController?.navigationBar.addSubview(titleViewCustom)
        searcher.searchBar.sizeToFit()
        
        let newFrame = searcher.searchBar.frame
        searcher.searchBar.frame = CGRectMake(newFrame.origin.x,newFrame.origin.y,newFrame.size.width-100,newFrame.size.height)
    
        self.definesPresentationContext = true

        let button = UIButton(frame: CGRectMake(0,20,20,20) )
        button.setImage(UIImage(named: "btn-cart"), forState: .Normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        button.addTarget(self, action: "pushCartScreen", forControlEvents: .TouchUpInside)
        
        let CartButton = BBBadgeBarButtonItem(customUIButton: button)
        CartButton.badgeValue = "0"
        CartButton.badgeOriginX = 13
        CartButton.badgeOriginY = -9
        CartButton.shouldHideBadgeAtZero = true
        CartButton.badgeBGColor = UIColor.whiteColor()
        CartButton.badgeTextColor = UIColor.redColor()
        //CartButton.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        
        self.navigationItem.rightBarButtonItem = CartButton
        
    }
    
    func pushCartScreen(){
        self.performSegueWithIdentifier("cartSegue", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cartSegue"{
            let destinationVC = segue.destinationViewController as! CartViewController
            destinationVC.items = self.cartItems
        }
    }


}

