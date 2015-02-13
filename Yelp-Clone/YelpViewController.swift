//
//  ViewController.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/10/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit
import MapKit

class YelpViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var searchBar: UISearchBar!
    var yelpArray: NSArray!
    var pullRefreshControl: UIRefreshControl!
    var client: YelpClient!
    
    let yelpConsumerKey = "2OzIjqFIIpy9o5KGa3Tg-A"
    let yelpConsumerSecret = "XKyRdSuAJCo2_MJ7CroIXFodD6U"
    let yelpToken = "fnAtvAeALghdHe7hW6Au1EkbMQZ75HvG"
    let yelpTokenSecret = "GmyA6rp1D-Gmlgkr9Vl0fseK4tg"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func makeYelpRequest(searchTerm: NSString){

        SVProgressHUD.showProgress(0.4, status: "Loading")
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(searchTerm, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
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
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        //searchBar.delegate = self
        searchBar = UISearchBar()
        navigationBar.titleView = searchBar
        searchBar.delegate = self
        makeYelpRequest("Chocolate")
        pullRefreshControl = UIRefreshControl()
        pullRefreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(pullRefreshControl, atIndex: 0)

    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println(searchText)
//        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
//            return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//        })
//      

    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        makeYelpRequest(searchBar.text)
        searchBar.resignFirstResponder()
    }

    
    func onRefresh() {
        makeYelpRequest("Chocolate")
        self.pullRefreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        if let array = yelpArray {
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let businessDict = self.yelpArray![indexPath.row] as NSDictionary
        let businessName = businessDict["name"] as NSString
        let displayPhone = businessDict["display_phone"] as NSString
        let imageURL = businessDict["image_url"] as NSString
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
        
        cell.business = Business(businessName: businessName, displayPhone: displayPhone, imageURL: imageURL, ratingsURL: ratingsURL, ratingsURLlarge: ratingsURLlarge, categoriesStr: categoriesStr, lat: lat, lng: lng, address: address, reviewCount: reviewCount)
        
        println(cell.business)
        
        cell.businessName.text = businessName
        cell.businessName.preferredMaxLayoutWidth = cell.businessName.frame.size.width
        cell.thumbnailImage.setImageWithURL(NSURL(string: imageURL))
        cell.ratingImage.setImageWithURL(NSURL(string: ratingsURL))
        cell.categoriesLabel.text = categoriesStr
        cell.address.text = address
        cell.reviewCount.text = "\(reviewCount) reviews"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println(segue.identifier)
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

