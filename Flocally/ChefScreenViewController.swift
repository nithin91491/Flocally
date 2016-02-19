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
    
    @IBOutlet weak var starRating: RatingView!
    
    @IBOutlet weak var btnFollow:UIButton!
    
    var chef:Chef!
    
    var chefsDishes:[Dish] = [Dish]()
    
    var followers = [JSON]()
    
    var currentlyFollowing = false
   
    var searcher:UISearchController!
    var src:SearchResultsController!
    
    @IBAction func toogleFollow(sender: UIButton) {
       
        if !currentlyFollowing{
            let param = "chefid=\(chef._id)&userid=\(currentuser)"
            print(chef._id)
            RequestManager.request(.POST, baseURL: .followChef, parameterString: param, block: {  (data) -> () in
                print(data)
            })
            
            self.btnFollow.setBackgroundImage(UIImage(named: "UnFollow"), forState: .Normal)
            
        }
        else{
            let param = "chefid=\(chef._id)&userid=\(currentuser)"
            
            RequestManager.request(.POST, baseURL: .unfollowChef, parameterString: param, block: {  (data) -> () in
                print(data)
            })
            self.btnFollow.setBackgroundImage(UIImage(named: "Follow"), forState: .Normal)
            
        }
        
        let param = "/\(chef._id)"
        
        RequestManager.request(.GET, baseURL: .getChefDetails, parameterString: param, block: { [unowned self] (data) -> () in
            self.followers = (data[0] as JSON)["followers"].arrayValue
            
            self.currentlyFollowing = self.followers.filter { (JSON) -> Bool in
                JSON["user_id"].stringValue == currentuser
                }.count > 0 ? true : false
            })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "showChefRatings:")
        self.starRating.addGestureRecognizer(tap)
        
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
                let dishImageURLArray = dishJSON["image_urls"].arrayValue
                
                
                let dish = Dish(id: id, name: name, type: type, category: category, description: description, price: price, postedByName: "", postedByImageURL: "", postedByID: "", dishImageURL: dishImageURL,dishImageURLArray: dishImageURLArray)
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
        
        //Check if user is currently following
        
        let param = "/\(chef._id)"
        RequestManager.request(.GET, baseURL: .getChefDetails, parameterString: param, block: { [unowned self] (data) -> () in
            
            
            self.followers = (data[0] as JSON)["followers"].arrayValue
            
            
            self.currentlyFollowing = self.followers.filter { (JSON) -> Bool in
                JSON["user_id"].stringValue == currentuser
                }.count > 0 ? true : false
            
            
            if self.currentlyFollowing {
                self.btnFollow.setBackgroundImage(UIImage(named: "UnFollow"), forState: .Normal)
            }
            
            })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationController(){
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
        
        //SearchBar
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
        searcher.searchBar.sizeToFit()
        
        let newFrame = searcher.searchBar.frame
        searcher.searchBar.frame = CGRectMake(newFrame.origin.x,newFrame.origin.y,newFrame.size.width-100,newFrame.size.height)
        
        self.definesPresentationContext = true
        
       
        let n: Int! = self.navigationController?.viewControllers.count
        let myUIViewController = self.navigationController?.viewControllers[n-2]
        self.navigationItem.rightBarButtonItem = myUIViewController?.navigationItem.rightBarButtonItem
        
    }

    
    
    func showChefRatings(sender:UITapGestureRecognizer){
       self.performSegueWithIdentifier("ChefReviews", sender: sender)
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
            let gradientlayer = cell.imgFoodImage.layer.sublayers?.filter{$0.name == "gradientLayer"}.first!
            gradientlayer!.hidden = false
        }
        else{
            cell.imgFoodImage.image = UIImage(named: "dummy-image")
            
            if dish.dishImageURL == "" && dish.dishImageURLArray.count > 0 {
                
                let imageURL = dish.dishImageURLArray[0]["image_url"].stringValue
                downloader.download(imageURL, completionHandler: { url in
                    
                    guard url != nil else {return}
                    
                    let data = NSData(contentsOfURL: url)!
                    let image = UIImage(data:data)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        dish.dishImage = image
                        self.tableView.reloadRowsAtIndexPaths(
                            [indexPath], withRowAnimation: .None)
                    }
                    
                })
                
            }
            else{
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
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 282
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "ChefReviews"{
        
        let destinationVC = segue.destinationViewController as! ChefSectionReviewsViewController
        destinationVC.chef = chef
        
        }
    }
   

}
