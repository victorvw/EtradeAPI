//
//  Account.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 12/9/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct Account: Unmarshaling {
    // A text description of the account
    var description: String?
    
    // Numeric account ID
    var id: Int
    
    // The account's margin level
    var marginLevel: MarginLevel
    
    // The total value of the account. This includes cash plus stocks, options, mutual funds, and bonds.
    var netValue: Double?
    
    // The type of account
    var registrationType: AccountRegistrationType?
    
    init(object: MarshaledObject) throws {
        description = try? object.value(for: "accountDesc")
        id = try object.value(for: "accountId")
        marginLevel = try object.value(for: "marginLevel")
        
        // TODO: confirm with valid data
        netValue = try? object.value(for: "netAccountValue")
        if netValue == nil, let netValueString: String = try? object.value(for: "netAccountValue") {
            netValue = Double(netValueString)
        }
        
        registrationType  = try? object.value(for: "registrationType")
    }
}
