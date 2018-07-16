//
//  ExpireDate.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/14/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct ExpireDate: Unmarshaling {
    // The day (1-31) the option will expire
    var day: Int
    
    // The month (1-12) the option will expire
    var month: Int
    
    // The 4-digit year the option will expire
    var year: Int
    
    // Expiry type of the option
    var expiryType: ExpiryType
    
    init(object: MarshaledObject) throws {
        day = try object.value(for: "day")
        month = try object.value(for: "month")
        year = try object.value(for: "year")
        expiryType = try object.value(for: "expiryType")
    }
}
