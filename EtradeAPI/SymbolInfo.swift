//
//  SymbolInfo.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 2/18/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct SymbolInfo: Unmarshaling {
    // The market symbol for the share being bought or sold
    var symbol: String
    
    // Specifies whether options are being bought (call) or sold (put).
    var callPut: OptionChainType?
    
    // The 4-digit year the option will expire
    var expirationYear: Int?
    
    // The month (1-12) the option will expire
    var expirationMonth: Int?
    
    // The day (1-31) the option will expire
    var expirationDay: Int?
    
    // The strike price for the option specified in the order
    var strikePrice: Double?
    
    init(object: MarshaledObject) throws {
        symbol = try object.value(for: "symbol")
        callPut = try? object.value(for: "callPut")
        expirationYear = try? object.value(for: "expYear")
        expirationMonth = try? object.value(for: "expMonth")
        expirationDay = try? object.value(for: "expDay")
        strikePrice = try? object.value(for: "strikePrice")
    }
}

