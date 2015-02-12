//
//  YelpDetailsView.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/10/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit
import MapKit

class YelpDetailsViewController: UIViewController {
    
    var yelpDictionary: NSDictionary?
    
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var ratingsImage: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBAction func phoneCall(sender: AnyObject) {
        var url:NSURL? = NSURL(string: "tel://4097899223")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let yelpDictionary = self.yelpDictionary? {
            businessName.text = yelpDictionary["name"] as NSString
            println(yelpDictionary)
            var phone = yelpDictionary["display_phone"] as NSString
            phoneButton.setTitle("Call \(phone)", forState: .Normal)
            var image_url = yelpDictionary["image_url"] as NSString
            var ratings_url = yelpDictionary["rating_img_url_large"] as NSString
            var locationDictionary = yelpDictionary["location"] as NSDictionary
            var addressArray = locationDictionary["address"] as NSArray
            
            let categoriesArray = yelpDictionary["categories"] as NSArray
            var categoriesStr = ""
            for category in categoriesArray as NSArray {
                if !categoriesStr.isEmpty{
                    categoriesStr += ", "
                }
                categoriesStr += category[0] as NSString
            }
            categoriesLabel.text = categoriesStr
            var review_count = yelpDictionary["review_count"] as NSInteger
            reviewCount.text = "\(review_count) reviews"
            
            address.text = addressArray[0] as NSString
            var coordinate = locationDictionary["coordinate"] as NSDictionary
            var lat = coordinate["latitude"] as CLLocationDegrees
            var lng = coordinate["longitude"] as CLLocationDegrees
            ratingsImage.setImageWithURL(NSURL(string: ratings_url))
            let locationCoords = CLLocationCoordinate2D(
                latitude: lat,
                longitude: lng
            )
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegion(center: locationCoords, span: span)
            mapView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(locationCoords)
            mapView.addAnnotation(annotation)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
