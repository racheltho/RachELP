//
//  ViewController.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/10/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class YelpViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var searchBar: UISearchBar!
    var yelpArray: NSArray!
    var pullRefreshControl: UIRefreshControl!
    var client: YelpClient!
    var city: NSString!
    //var coords: CLLocationCoordinate2D!

    var search: NSString!
    var deals: Bool!
    var sortBy: NSInteger!
    
    let yelpConsumerKey = "2OzIjqFIIpy9o5KGa3Tg-A"
    let yelpConsumerSecret = "XKyRdSuAJCo2_MJ7CroIXFodD6U"
    let yelpToken = "fnAtvAeALghdHe7hW6Au1EkbMQZ75HvG"
    let yelpTokenSecret = "GmyA6rp1D-Gmlgkr9Vl0fseK4tg"
    
    let locationManager = CLLocationManager()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func makeYelpRequest(var searchTerm: NSString?, var city: NSString?, var sortBy: NSInteger?, var deals: Bool?){

        SVProgressHUD.showProgress(0.4, status: "Loading")
        
        if(searchTerm? == nil){
            searchTerm = "Restaurant"
        }
        if(city? == nil){
            city = "San Francisco"
        }
        if(sortBy? == nil){
            sortBy = 0
        }
        if(deals? == nil){
            deals = false
        }
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(searchTerm!, city: city!, sort: sortBy!, deals: deals!, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let dictionary = response as NSDictionary
            self.yelpArray = dictionary["businesses"] as NSArray
            self.tableView.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        SVProgressHUD.dismiss()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchBar = UISearchBar()
        navigationBar.titleView = searchBar
        searchBar.delegate = self
        //makeYelpRequest(search, city: city, sortBy: sortBy, deals: deals)
        pullRefreshControl = UIRefreshControl()
        pullRefreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(pullRefreshControl, atIndex: 0)

    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("inside location manager")
//        var locationArray = locations as NSArray
//        var locationObj = locationArray.lastObject as CLLocation
//        var coord = locationObj.coordinate
//        var lng = coord.longitude
//        var lat = coord.latitude
//        println(lng)
//        println(lat)
//        manager.stopUpdatingLocation()
//        self.makeYelpRequest(self.categories, city: self.city)
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
            }
            if(placemarks != nil){
                if placemarks.count > 0 {
                    let pm = placemarks[0] as CLPlacemark
                    self.city = pm.locality
                    println(self.city)
                    manager.stopUpdatingLocation()
                } else {
                    println("Problem with the data received from geocoder")
                }
            }
            self.makeYelpRequest(self.search, city: self.city, sortBy: self.sortBy, deals: self.deals)
        })
    }
    
//    func displayLocationInfo(placemark: CLPlacemark) {
//        if let placemark2 = placemark {
//            //stop updating location to save battery life
//            locationManager.stopUpdatingLocation()
//            println(placemark.locality ? placemark.locality : "")
//            println(placemark.postalCode ? placemark.postalCode : "")
//            println(placemark.administrativeArea ? placemark.administrativeArea : "")
//            println(placemark.country ? placemark.country : "")
//        }
//
//        
//    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        makeYelpRequest(searchBar.text, city: city, sortBy: sortBy, deals: deals)
        searchBar.resignFirstResponder()
    }

    
    func onRefresh() {
        makeYelpRequest(search, city: city, sortBy: sortBy, deals: deals)
        self.pullRefreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        if let array = yelpArray {
            return array.count
        } else {
            return 0
        }
    }
    
//    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
//        if(index == 0){
//            return "Sort by"
//        }else{
//            return "
//        }
//    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let businessDict = self.yelpArray![indexPath.row] as NSDictionary
        let businessName = businessDict["name"] as NSString
        let displayPhone = businessDict["display_phone"]? as NSString?
        let phone = businessDict["phone"]? as NSString?
        let imageURL = businessDict["image_url"]? as NSString?
        let ratingsURL = businessDict["rating_img_url"] as NSString
        let ratingsURLlarge = businessDict["rating_img_url_large"] as NSString
        let categoriesArray = businessDict["categories"] as NSArray
        var categoriesStr = ""
        for category in categoriesArray as NSArray {
            if !categoriesStr.isEmpty{
                categoriesStr += ", "
            }
            categoriesStr += category[0] as NSString
        }
        let locationDict = businessDict["location"] as NSDictionary
        let addressArray = locationDict["address"] as NSArray
        let address = addressArray[0] as NSString
        let coordinate = locationDict["coordinate"] as NSDictionary
        let lat = coordinate["latitude"] as CLLocationDegrees
        let lng = coordinate["longitude"] as CLLocationDegrees
        let reviewCount = businessDict["review_count"] as NSInteger
        
        let cell = tableView.dequeueReusableCellWithIdentifier("yelpCell") as YelpCell
        
        cell.business = Business(businessName: businessName, displayPhone: displayPhone, phone: phone, imageURL: imageURL, ratingsURL: ratingsURL, ratingsURLlarge: ratingsURLlarge, categoriesStr: categoriesStr, lat: lat, lng: lng, address: address, reviewCount: reviewCount)
        
        cell.businessName.text = businessName
        cell.businessName.preferredMaxLayoutWidth = cell.businessName.frame.size.width
        if (imageURL? != nil) {
            cell.thumbnailImage.setImageWithURL(NSURL(string: imageURL!))
        }
        cell.ratingImage.setImageWithURL(NSURL(string: ratingsURL))
        cell.categoriesLabel.text = categoriesStr
        cell.address.text = address
        cell.reviewCount.text = "\(reviewCount) reviews"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "yelpDetailsSegue" {
            let cell = sender as YelpCell
            if let indexPath = tableView.indexPathForCell(cell) {
                let detailsController = segue.destinationViewController as YelpDetailsViewController
                detailsController.business = cell.business as Business
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }

}

