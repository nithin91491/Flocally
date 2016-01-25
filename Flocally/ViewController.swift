//
//  ViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/4/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit
//import PagingMenuController

class ViewController: UIViewController,PagingMenuControllerDelegate,UISearchBarDelegate{

    var searchBar = UISearchBar()
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
        //breakFast.container = containerView
        
        let lunch = self.storyboard?.instantiateViewControllerWithIdentifier("Lunch") as! LunchTableViewController
        lunch.title = "LUNCH"
        let dinner = self.storyboard?.instantiateViewControllerWithIdentifier("Dinner") as! DinnerTableViewController
        dinner.title = "DINNER"
        
        let snacks = self.storyboard?.instantiateViewControllerWithIdentifier("Snacks") as! SnacksTableViewController
        snacks.title = "SNACKS"
        
        let viewControllers = [breakFast,lunch,snacks,dinner]
        
        let options = PagingMenuOptions()
        options.menuHeight = 30
        options.selectedTextColor = UIColor.whiteColor()
        options.backgroundColor = UIColor.redColor()
        options.selectedBackgroundColor = UIColor.redColor()
        
//        let pagingMenuControllerNav = self.childViewControllers.first as! UINavigationController
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        
//        let pagingMenuController = self.storyboard?.instantiateViewControllerWithIdentifier("PagingMenuController") as! PagingMenuController
        pagingMenuController.delegate = self
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
    }
    
    func setupNavigationController(){
       
        //Title view
//        let attribute1 = [NSFontAttributeName:UIFont.systemFontOfSize(16),NSForegroundColorAttributeName : UIColor.whiteColor()]
//        let title1:NSMutableAttributedString = NSMutableAttributedString(string: "Today's Special",attributes: attribute1)
//        
//        let attribute2 = [NSFontAttributeName:UIFont.systemFontOfSize(12),NSForegroundColorAttributeName : UIColor.whiteColor()]
//        let title2:NSAttributedString = NSAttributedString(string: " Mayur vihar phase II",attributes: attribute2)
//        
//        title1.appendAttributedString(title2)
//        
//        label.attributedText = title1
//        label.sizeToFit()
//        navigationItem.titleView = label
        
        
        //SearchBar
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.redColor()
        searchBar.setSearchFieldBackgroundImage(UIImage(named: "searchBG"), forState: .Normal)
        
        let txfSearchField:UITextField = searchBar.valueForKey("_searchField") as! UITextField
        
        txfSearchField.attributedPlaceholder = NSAttributedString(string:" Search your meal..", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        txfSearchField.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = self.searchBar
        
        
        
        
        
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
    
   

    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            self.searchBar.resignFirstResponder()

        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

