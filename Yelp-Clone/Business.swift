//
//  Business.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/12/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit
import MapKit


class Business: NSObject {
    var businessName: NSString
    var displayPhone: NSString
    var imageURL: NSString
    var ratingsURL: NSString
    var ratingsURLlarge: NSString
    var categoriesStr: NSString
    var lat: CLLocationDegrees
    var lng: CLLocationDegrees
    var address: NSString
    var reviewCount: NSInteger
    
    init(businessName: NSString, displayPhone: NSString, imageURL: NSString, ratingsURL: NSString, ratingsURLlarge: NSString, categoriesStr: NSString, lat: CLLocationDegrees, lng: CLLocationDegrees, address: NSString, reviewCount: NSInteger){
        self.businessName = businessName
        self.displayPhone = displayPhone
        self.imageURL = imageURL
        self.ratingsURL = ratingsURL
        self.ratingsURLlarge = ratingsURLlarge
        self.categoriesStr = categoriesStr
        self.lat = lat
        self.lng = lng
        self.address = address
        self.reviewCount = reviewCount
    }
    
    
}
