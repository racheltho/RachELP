//
//  YelpDetailsView.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/10/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class YelpDetailsViewController: UIViewController {
    
    var yelpDictionary: NSDictionary?
    
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var ratingsImage: UIImageView!
    @IBOutlet weak var yelpImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let yelpDictionary = self.yelpDictionary? {
            businessName.text = yelpDictionary["name"] as NSString
            println(yelpDictionary)
            phone.text = yelpDictionary["display_phone"] as NSString
            var image_url = yelpDictionary["image_url"] as NSString
            var ratings_url = yelpDictionary["rating_img_url_large"] as NSString
            yelpImage.setImageWithURL(NSURL(string: image_url))
            ratingsImage.setImageWithURL(NSURL(string: ratings_url))

            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
