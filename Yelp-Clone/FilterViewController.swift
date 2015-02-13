//
//  FilterViewController.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/11/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

class FilterViewController: UIViewController, UITableViewDataSource {
    
    let CATEGORIES = [["name" : "Afghan", "code": "afghani"],
        ["name" : "Barbeque", "code": "bbq"],
        ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
        ["name" : "Burmese", "code": "burmese"],
        ["name" : "Cajun/Creole", "code": "cajun"]]
//        ["name" : "Comfort Food", "code": "comfortfood"],
//        ["name" : "Cuban", "code": "cuban"],
//        ["name" : "Ethiopian", "code": "ethiopian"],
//        ["name" : "Hot Dogs", "code": "hotdog"],
//        ["name" : "Indian", "code": "indpak"],
//        ["name" : "Italian", "code": "italian"],
//        ["name" : "Japanese", "code": "japanese"],
//        ["name" : "Latin American", "code": "latin"],
//        ["name" : "Pizza", "code": "pizza"],
//        ["name" : "Salad", "code": "salad"],
//        ["name" : "Soul Food", "code": "soulfood"],
//        ["name" : "Steakhouses", "code": "steak"],
//        ["name" : "Sushi Bars", "code": "sushi"],
//        ["name" : "Swedish", "code": "swedish"],
//        ["name" : "Thai", "code": "thai"],
//        ["name" : "Vietnamese", "code": "vietnamese"]]
//    
    
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        if let array = CATEGORIES {
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filtercell", forIndexPath: indexPath) as FilterTableViewCell
        return cell
    }
    
}

