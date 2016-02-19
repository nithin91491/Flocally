//
//  DishScreenViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 1/27/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class DishScreenViewController: UIViewController {

    
    @IBOutlet weak var imgDishImage: UIImageView!
    
    @IBOutlet weak var lblDishName: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var txvDescription: UILabel!
    
    @IBOutlet weak var imgVegIndicator: UIImageView!
    
    @IBOutlet weak var lblQuantity: UILabel!
    
    @IBOutlet weak var imgDish1: UIImageView!
    
    @IBOutlet weak var imgDish2: UIImageView!
    
    @IBOutlet weak var imgDish3: UIImageView!
    
    var dish:Dish!
    var initialQuantity:Int = 0
    var gradientAdded = false
    
    var searcher:UISearchController!
    
//    var src:SearchResultsController!
    let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func changeQuantity(sender: UIButton) {
        if sender.tag == 1{ //Increment
            self.lblQuantity.text = String(++initialQuantity)
        }
        else{ //Decrement
            guard initialQuantity > 0 else {return}
            self.lblQuantity.text = String(--initialQuantity)
        }
        
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        
//        let button = UIButton(type: .System)
//        button.frame = CGRectMake(0, 0, 100, 50)
//        button.backgroundColor = UIColor.redColor()
//        button.setTitle("Search Button", forState: UIControlState.Normal)
//        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.navigationItem.titleView = button

        self.imgDishImage.image = dish.dishImage
        if self.imgDishImage.image != nil{
            self.imgDishImage.addBottomGradient(UIColor.blackColor().CGColor as CGColorRef)
            let gradientlayer = self.imgDishImage.layer.sublayers?.filter{$0.name == "gradientLayer"}.first!
            gradientlayer?.hidden = false
        }
        self.lblDishName.text = dish.name
        self.lblPrice.text =  "₹"+String(dish.price)
        self.txvDescription.text = dish.description
        self.lblQuantity.text = String(initialQuantity)
        
        if dish.category == "non-veg"{
            imgVegIndicator.image = UIImage(named: "nonveg")
        }else{
            imgVegIndicator.image = UIImage(named: "veg")
        }
        
        if dish.dishImageURLArray.count == 0 {
            self.imgDish1.image = dish.dishImage
            self.imgDish2.image = dish.dishImage
            self.imgDish3.image = dish.dishImage
        }
        
        for i in 0..<dish.dishImageURLArray.count {
        
        let imageURL = dish.dishImageURLArray[i]["image_url"].stringValue
        
        downloader.download(imageURL, completionHandler: { url in
            
            guard url != nil else {return}
            
            let data = NSData(contentsOfURL: url)!
            let image = UIImage(data:data)
            
            switch(i){
            case 0 : self.imgDish1.image = image
            case 1 : self.imgDish2.image = image
            case 2:  self.imgDish3.image = image
            default: break
            }
            
        })
        
        }
        
        
    }
    
    func buttonAction(sender:UIButton){
        let src = SearchResultsController()
        self.presentViewController(src, animated: true, completion: nil)
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
       let src = searchResultsController
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//    }
    

}
