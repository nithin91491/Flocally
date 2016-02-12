//
//  ViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/4/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit
//import PagingMenuController

class ViewController: UIViewController,PagingMenuControllerDelegate,CustomSearchControllerDelegate{

    var leftSearchBarButtonItem: UIBarButtonItem?
    var rightSearchBarButtonItem: UIBarButtonItem?
    let label = UILabel()
    var customSearchController:CustomSearchController!
    var src:SearchResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupPagingViewControllers()
       setupNavigationController()
        
    }
    

    override func viewWillAppear(animated: Bool) {
        
        
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
    }
    
    func setupNavigationController(){
        
        let searchResultsController = SearchResultsController()
        
        src = searchResultsController
        let frame = CGRectMake(0, 0, (self.navigationController?.navigationBar.frame.size.width)!, 35.0)
        let searchBarFrame = CGRectMake(-8, 8, frame.size.width-100, 30)
        let barTintColor = UIColor.redColor()
        
        customSearchController = CustomSearchController(searchResultsController: searchResultsController, searchBarFrame: searchBarFrame, searchBarFont: UIFont(name: "Roboto-Regular", size: 14.0)!, searchBarTextColor: UIColor.whiteColor(), searchBarTintColor: barTintColor)
        
        customSearchController.customDelegate = self
        
        
        
        let titleViewCustom = UIView(frame:frame)
        titleViewCustom.addSubview(customSearchController.customSearchBar)
        titleViewCustom.backgroundColor = UIColor.clearColor()
        self.navigationItem.titleView = titleViewCustom
        
       // self.searcher = searchResultsController.customSearchController
        self.definesPresentationContext = true

    }
    
    
    func didStartSearching() {
        //        shouldShowSearchResults = true
        //        tblSearchResults.reloadData()
        
        if (((self.presentedViewController?.isEqual(src)) ) != nil) {
            src.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
        self.presentViewController(src, animated: true, completion: nil)
        }
        
    }
    
    
    func didTapOnSearchButton() {
        //        if !shouldShowSearchResults {
        //            shouldShowSearchResults = true
        //            tblSearchResults.reloadData()
        //        }
    }
    
    
    func didTapOnCancelButton() {
        //        shouldShowSearchResults = false
        //        tblSearchResults.reloadData()
    }
    
    
    func didChangeSearchText(searchText: String) {
        
//        filteredArray = DataManager.sharedInstance.dishes.filter({ (dish) -> Bool in
//            let dishName = dish.name
//            
//            return (dishName.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch) != nil)
//        })
//        
//        // Reload the tableview.
//        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

