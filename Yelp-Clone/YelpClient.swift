//
//  YelpClient.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/10/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import MapKit
import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        //var token = BD
        
        var token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, city: String, sort: Int, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        println(sort)
        var parameters = ["term": term, "location": city, "sort": sort]
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
    
}
