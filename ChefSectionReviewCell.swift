//
//  ChefSectionReviewCell.swift
//  Flocally
//
//  Created by Nikhil Srivastava on 2/4/16.
//  Copyright © 2016 Nikhil Srivastava. All rights reserved.
//

import UIKit

class ChefSectionReviewCell: UITableViewCell {

    
    @IBOutlet weak var imgUserProfilePic: UIImageView!
    
    @IBOutlet weak var lblCommentTitle: UILabel!
    
    @IBOutlet weak var lblComments: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var starRating: RatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
