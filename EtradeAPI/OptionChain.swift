//
//  OptionChain.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/24/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct OptionChain: Unmarshaling {
    // The number of option pairs returned
    var optionPairCount: Int
    
    // Container for an option pair. There will be one of these for each option pair in the response.
    var optionPairs: [OptionPair]
    
    // The market symbol for the instrument
    var symbol: String
    
    init(object: MarshaledObject) throws {
        optionPairCount = try object.value(for: "optionPairCount")
        optionPairs = try object.value(for: "optionPairs")
        symbol = try object.value(for: "symbol")
    }
}
