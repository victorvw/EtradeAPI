//
//  LegDetail.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 2/18/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct LegDetail: Unmarshaling {
    // The number associated with this leg of the order. For example, buy-write orders have two legs.
    var legNumber: Int
    
    // Text description of the security
    var symbolDescription: String
    
    // The action that the broker is requested to perform.
    var orderAction: OrderAction
    
    // The number of shares ordered
    var orderedQuantity: Double
    
    // The number of shares actually filled in the order
    var filledQuantity: Double
    
    // The price the stock was actually purchased for
    var executedPrice: Double
    
    // The cost billed to the user to perform the requested action
    var estimatedCommission: Double
    
    // The total amount of fees billed to the user to fill the order
    var estimatedFees: Double
    
    
    
    init(object: MarshaledObject) throws {
        legNumber = try object.value(for: "legNumber")
        symbolDescription = try object.value(for: "symbolDescription")
        orderAction = try object.value(for: "orderAction")
        orderedQuantity = try object.value(for: "orderedQuantity")
        filledQuantity = try object.value(for: "filledQuantity")
        executedPrice = try object.value(for: "executedPrice")
        estimatedCommission = try object.value(for: "estimatedCommission")
        estimatedFees = try object.value(for: "estimatedFees")
    }
}
