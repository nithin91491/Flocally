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
    var chef:Chef!
    
    var chefsDishes:[Dish] = [Dish]()
    
   
    @IBAction func toogleFollow(sender: UIButton) {
        
        
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
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
        
//        //SearchBar
        let frame = CGRectMake(0, 0, (self.navigationController?.navigationBar.frame.size.width)!, 35.0)
        
        let searchResultsController = SearchResultsController(searchBarFrame: CGRectMake(-8, 8, frame.size.width-100, 30) )
        
        
        let titleViewCustom = UIView(frame:frame)
        titleViewCustom.addSubview(searchResultsController.customSearchController.customSearchBar)
        titleViewCustom.backgroundColor = UIColor.clearColor()
        self.navigationItem.titleView = titleViewCustom
       
        
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
