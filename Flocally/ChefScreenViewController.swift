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
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var txvChefsDescription: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var chef:Chef!
    
    var chefsDishes:[Dish] = [Dish]()
    
    //var chefs = [Chef]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
       
        //Parse Chef's Dishes
        let dishes = chef.dishes
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { () -> Void in
            
            dishes.forEach { (dishJSON) -> () in
                let id:String = dishJSON["_id"].stringValue
                let name:String = dishJSON["name"].stringValue
                let dishImageURL:String = dishJSON["image_url"].stringValue
                let description:String = dishJSON["desc"].stringValue
                let category:String = dishJSON["category"].stringValue
                let price:Double = dishJSON["price"].doubleValue
                let type:String = dishJSON["type"].stringValue
                
                let dish = Dish(id: id, name: name, type: type, category: category, description: description, price: price, postedByName: "", postedByImageURL: "", postedByID: "", dishImageURL: dishImageURL)
                self.chefsDishes.append(dish)
                
            }
            
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
            }
        }
        
       
        
        //Load Chef details
        self.lblName.text = chef.name
        self.txvChefsDescription.text = chef.aboutme
        let chefImageURL = chef.profilePictureURL
        
        downloader.download(chefImageURL) { url in
            guard url != nil else {return}
            
            let data = NSData(contentsOfURL: url)!
            let image = UIImage(data: data)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imgProfilePic.image = image
            })
            
        }
        
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
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
        
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
      let cell = tableView.dequeueReusableCellWithIdentifier("ChefScreenCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        let dish = chefsDishes[indexPath.row] as Dish
        
        cell.lblFoodName.text = dish.name
        cell.lblDescription.text = dish.description
        cell.lblPrice.text = "₹" + String(dish.price)
        
        if dish.category == "non-veg"{
            cell.imgVegIndicator.image = UIImage(named: "nonveg")
        }else{
            cell.imgVegIndicator.image = UIImage(named: "veg")
        }
        
        if let dishImage = dish.dishImage{
            cell.imgFoodImage.image = dishImage
        }
        else{
            cell.imgFoodImage.image = nil
            downloader.download(dish.dishImageURL, completionHandler: { url in
               
                guard url != nil else {return}
                
                let data = NSData(contentsOfURL: url)!
                let image = UIImage(data: data)
                dish.dishImage = image
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                })
                
            })
        }
        
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chefsDishes.count
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
