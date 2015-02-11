//
//  ViewController.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/10/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class YelpViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    //@IBOutlet weak var searchBar: UISearchBar!
    
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
            //let dictionary = NSJSONSerialization.JSONObjectWithData(response, options: nil, error: nil) as NSDictionary
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
        makeYelpRequest("Thai")
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
        let business = self.yelpArray![indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("yelpCell") as YelpCell
        cell.businessName.text = business["name"] as NSString
        var image_url = business["image_url"] as NSString
        var rating_url = business["rating_img_url"] as NSString
        cell.thumbnailImage.setImageWithURL(NSURL(string: image_url))
        cell.ratingImage.setImageWithURL(NSURL(string: rating_url))
        let categoriesArray = business["categories"] as NSArray
        var categoriesStr = ""
        for category in categoriesArray as NSArray {
            if !categoriesStr.isEmpty{
                categoriesStr += ", "
            }
            categoriesStr += category[0] as NSString
        }
        cell.categoriesLabel.text = categoriesStr
        var location = business["location"] as NSDictionary
        var addressArray = location["address"] as NSArray
        cell.address.text = addressArray[0] as NSString
        var review_count = business["review_count"] as NSInteger
        cell.reviewCount.text = "\(review_count) reviews"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println(segue.identifier)
        if segue.identifier == "yelpDetailsSegue" {
            let cell = sender as YelpCell
            if let indexPath = tableView.indexPathForCell(cell) {
                let detailsController = segue.destinationViewController as YelpDetailsViewController
                detailsController.yelpDictionary = self.yelpArray![indexPath.row] as? NSDictionary
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }


}

