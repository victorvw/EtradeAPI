//
//  RateLimitStatus.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/15/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct RateLimitStatus: Unmarshaling {
    // The string used by the consumer to identify itself to the service provider
    var oauthConsumerKey: String
    
    // The interval for which the limit applies, in seconds
    var limitIntervalInSeconds: Int
    
    // The remaining number of requests that the system will accept from the user in the current time interval
    var requestsRemaining: Int
    
    // The time when the next interval will begin
    var resetTime: String
    
    // The time when the next interval will begin, in epoch time
    var resetTimeEpochSeconds: Int
    
    init(object: MarshaledObject) throws {
        oauthConsumerKey = try object.value(for: "consumerKey")
        limitIntervalInSeconds = try object.value(for: "limitIntervalInSeconds")
        requestsRemaining = try object.value(for: "requestsRemaining")
        resetTime = try object.value(for: "resetTime")
        resetTimeEpochSeconds = try object.value(for: "resetTimeEpochSeconds")
    }
}
