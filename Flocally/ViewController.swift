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
    let label = UILabel()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupPagingViewControllers()
       setupNavigationController()
        
    }
    

    override func viewWillAppear(animated: Bool) {
        
        
    }
    
    func setupPagingViewControllers(){
        
        let breakFast = self.storyboard?.instantiateViewControllerWithIdentifier("BreakFast") as! BreakFastTableViewController
        breakFast.title = "BREAKFAST"
    
        
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
    }
    
    func setupNavigationController(){
        
        let frame = CGRectMake(0, 0, (self.navigationController?.navigationBar.frame.size.width)!, 35.0)
        
        let searchResultsController = SearchResultsController(searchBarFrame: CGRectMake(-5, 8, frame.size.width-100, 30) )
       
        
        let titleViewCustom = UIView(frame:frame)
        titleViewCustom.addSubview(searchResultsController.customSearchController.customSearchBar)
        titleViewCustom.backgroundColor = UIColor.clearColor()
        self.navigationItem.titleView = titleViewCustom
        
        
        //Hamburger-Left Item
//        if self.revealViewController() != nil {
//            
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .Plain, target: self.revealViewController(), action: "revealToggle:")
//            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
//            
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            
//        }

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

