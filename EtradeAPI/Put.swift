//
//  Put.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/24/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct Put: Unmarshaling {
    // The underlier for the option as originally contracted. For adjusted options, this root symbol may not match the current symbol.
    var rootSymbol: String
    
    // Expiration Date
    var expireDate: ExpireDate
    
    // Product
    var product: Product
    
    // The agreed strike price for the option, as stated in the contract
    var strikePrice: Double?
    
    init(object: MarshaledObject) throws {
        rootSymbol = try object.value(for: "rootSymbol")
        expireDate = try object.value(for: "expireDate")
        product = try object.value(for: "product")
        
        // TODO: confirm with valid data
        if let strikePriceString: String = try? object.value(for: "strikePrice") {
            strikePrice = Double(strikePriceString)
        }
    }
}
