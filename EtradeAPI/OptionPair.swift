//
//  OptionPair.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/24/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct OptionPair: Unmarshaling {
    // The number of call objects
    var callCount: Int?
    
    // The number of put objects
    var putCount: Int?
    
    // Determines whether the response will contain calls, puts, or both
    var pairType: OptionPairType
    
    // Call
    var calls: [Call]?
    
    // Put
    var puts: [Put]?
    
    init(object: MarshaledObject) throws {
        callCount = try? object.value(for: "callCount")
        putCount = try? object.value(for: "putCount")
        pairType = try object.value(for: "pairType")
        
        // TODO: confirm with valid data
        if let callCount = callCount, callCount > 1 {
            calls = try? object.value(for: "call")
        } else if let call: Call = try? object.value(for: "call") {
            calls = [call]
        }
        
        // TODO: confirm with valid data
        if let callCount = callCount, callCount > 1 {
            puts = try? object.value(for: "put")
        } else if let put: Put = try? object.value(for: "put") {
            puts = [put]
        }
        
    }
}
