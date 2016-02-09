//
//  ChefSectionReviewsViewController.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/4/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit
import Foundation

class ChefSectionReviewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var imgChefProfile: UIImageView!
    
    @IBOutlet weak var lblChefName: UILabel!
    
    @IBOutlet weak var starRating: RatingView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var chef:Chef!
    var ratings=[JSON]()
    var sum:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let param = "/\(chef._id)"
        
        
        
        RequestManager.request(.GET, baseURL: .getChefReview, parameterString: param) { [unowned self] (data) -> () in
          let ratings = (data[0] as JSON)["ratings"].arrayValue
            
            for rating in ratings{
                self.ratings.append(rating)
                self.sum += rating["point"].floatValue
            }
            self.tableView.reloadData()
            
            let average = Int(self.sum)/ratings.count
            self.starRating.rating = Float(round(Double(average)))
            
        }
        
        
        
    }

    
    
    //MARK:- Table View
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("ChefReviewCell", forIndexPath: indexPath) as! ChefSectionReviewCell
        
        let comments = self.ratings[indexPath.row]["comment"].stringValue
        
        if comments.characters.count > 10{
          cell.lblCommentTitle.text = comments.substringToIndex(comments.startIndex.advancedBy(10))
        }
        else{
            cell.lblCommentTitle.text = comments.substringToIndex(comments.endIndex)
        }
        
        cell.lblComments.text = comments
        
        if let url = NSURL(string: self.ratings[indexPath.row]["userprofilepic"].stringValue){
            downloader.download(self.ratings[indexPath.row]["userprofilepic"].stringValue) { url in
                
                guard url != nil else {return}
                
                let data = NSData(contentsOfURL: url)!
                let image = UIImage(data:data)
                
                dispatch_async(dispatch_get_main_queue()){
                    cell.imgUserProfilePic.image = image
                }
            }
        }
        else{
            cell.imgUserProfilePic.image = nil
        }
        
        let dateString = self.ratings[indexPath.row]["timestamp"].stringValue
        let endIndex = dateString.startIndex.advancedBy(10)
        cell.lblDate.text = dateString.substringToIndex(endIndex)
        
        cell.starRating.rating = self.ratings[indexPath.row]["point"].floatValue
        
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
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
