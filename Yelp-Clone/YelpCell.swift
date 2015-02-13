//
//  YelpCell.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/10/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class YelpCell: UITableViewCell {
    
    
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business!
    
    override func awakeFromNib() {
        businessName.preferredMaxLayoutWidth = businessName.frame.size.width
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        businessName.preferredMaxLayoutWidth = businessName.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
