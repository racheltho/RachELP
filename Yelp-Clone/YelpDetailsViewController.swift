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
    
    var business: Business?
    
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
        if let business = self.business? {
            businessName.text = business.businessName
            let phone = business.displayPhone
            phoneButton.setTitle("Call \(phone)", forState: .Normal)
            categoriesLabel.text = business.categoriesStr
            reviewCount.text = "\(business.reviewCount) reviews"
            address.text = business.address
            let ratings_url = business.ratingsURLlarge
            ratingsImage.setImageWithURL(NSURL(string: business.ratingsURLlarge))
            
            let locationCoords = CLLocationCoordinate2D(
                latitude: business.lat,
                longitude: business.lng
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
