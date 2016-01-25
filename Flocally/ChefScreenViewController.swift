//
//  ChefScreenViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/25/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class ChefScreenViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.navigationItem.setHidesBackButton(true, animated: false)
        setupNavigationController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
    
    
    //MARK : - Table View
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("ChefScreenCell", forIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
