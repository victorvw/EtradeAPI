//
//  Product.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/14/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct Product: Unmarshaling {
    // The name of the company
    var companyName: String?
    
    // The exchange that lists the company
    var exchange: Exchange
    
    // The type of security
    var securityType: SecurityType
    
    // The market symbol for this security
    var symbol: String
    
    init(object: MarshaledObject) throws {
        // API key is not consistent for securityType ("securityType" or "type")
        let securityTypeKey = ((object as! MarshalDictionary).keys).first(where: { !(["companyName", "exchange", "exchangeCode", "symbol"].contains($0)) })!
        let exchangeKey = ((object as! MarshalDictionary).keys).first(where: { !(["companyName", securityTypeKey, "symbol"].contains($0)) })!
        
        companyName = try? object.value(for: "companyName")
        exchange = try object.value(for: exchangeKey)
        securityType = try object.value(for: securityTypeKey)
        symbol = try object.value(for: "symbol")
    }
}
