//
//  SearchResultsController.swift
//  GergStore
//
//  Created by Nikhil Srivastava on 12/23/15.
//  Copyright © 2015 Nikhil Srivastava. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController,CustomSearchControllerDelegate,UISearchResultsUpdating {

    var customSearchController:CustomSearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customSearchController.searchResultsUpdater = self
        
        
    }
    
    init(searchBarFrame:CGRect){
       super.init(nibName: nil, bundle: nil)
        
        let barTintColor = UIColor.redColor()
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: searchBarFrame, searchBarFont: UIFont(name: "Roboto-Regular", size: 14.0)!, searchBarTextColor: UIColor.whiteColor(), searchBarTintColor: barTintColor)
        
        customSearchController.customDelegate = self
        
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
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //Custom search controller delegate methods
    func didStartSearching() {
        //        shouldShowSearchResults = true
        //        tblSearchResults.reloadData()
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
        // Filter the data array and get only those countries that match the search text.
        //        filteredArray = dataArray.filter({ (country) -> Bool in
        //            let countryText: NSString = country
        //
        //            return (countryText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        //        })
        //
        //        // Reload the tableview.
        //        tblSearchResults.reloadData()
    }


}
