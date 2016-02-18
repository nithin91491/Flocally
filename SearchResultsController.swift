//
//  SearchResultsController.swift
//  GergStore
//
//  Created by Nikhil Srivastava on 12/23/15.
//  Copyright © 2015 Nikhil Srivastava. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController,UISearchResultsUpdating {

    var navigation:UINavigationController!
    
    var filteredArray = [Dish]()
    
    var searcher:UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.searcher = UISearchController(searchResultsController: nil)
//        
//        
//        searcher.searchBar.setSearchFieldBackgroundImage(UIImage(named: "searchBG"), forState: .Normal)
//        searcher.searchBar.searchBarStyle = .Minimal
//        
//        searcher.dimsBackgroundDuringPresentation = false
//        searcher.hidesNavigationBarDuringPresentation = false
//        searcher.searchBar.showsCancelButton = false
//        searcher.searchResultsUpdater = self
//        searcher.searchBar.tintColor = UIColor.whiteColor()
//        searcher.searchBar.setImage(UIImage(named: "SearchIcon")!, forSearchBarIcon: .Search, state: .Normal)
//        searcher.searchBar.delegate = self
//        
//        let placeholder = NSAttributedString(string:" Search your meal..", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
//        
//        if #available(iOS 9.0, *) {
//            UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).attributedPlaceholder = placeholder
//            UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).textColor = UIColor.whiteColor()
//        } else {
//            
//            for subview in searcher.searchBar.subviews[0].subviews {
//                if subview.isKindOfClass(UITextField) {
//                    let textfield = subview as! UITextField
//                    textfield.attributedPlaceholder = placeholder
//                    textfield.textColor = UIColor.whiteColor()
//                }
//            }
//            
//        }
//        
//        self.tableView.tableHeaderView = searcher.searchBar
//        searcher.searchBar.sizeToFit()
//         self.definesPresentationContext = true
        
    }
    
    init(){
        
       super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    //MARK:- Search results updating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        filteredArray = DataManager.sharedInstance.dishes.filter({ (dish) -> Bool in
            let dishName = dish.name
            
            return (dishName.rangeOfString(searchController.searchBar.text!, options: NSStringCompareOptions.CaseInsensitiveSearch) != nil)
        })
        
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("searchCell") as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style:.Default, reuseIdentifier: "searchCell")
        }

        let filteredDish = filteredArray[indexPath.row] 
       cell.textLabel?.text = filteredDish.name
        if filteredDish.dishImage != nil{
        cell.imageView?.image = filteredDish.dishImage
        }
        else{
           cell.imageView?.image = UIImage(named: "dummy-image")
        }
        
        cell.imageView?.clipsToBounds = true
        cell.imageView?.contentMode = .ScaleAspectFill
        cell.imageView?.frame = CGRectMake(0, 0, 80, 50)
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedDish = filteredArray[indexPath.row]
        
       let dishVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("dishVC") as! DishScreenViewController
       dishVC.dish = selectedDish
        
        self.navigation.pushViewController(dishVC, animated: true)
        (self.presentingViewController as? ViewController)?.searcher.active = false
        
    }
   
}

