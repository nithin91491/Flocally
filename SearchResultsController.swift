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

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        
        print(self.presentingViewController)
        
    }
   
}

