//
//  GroupOrder.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 2/18/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct GroupOrder: Unmarshaling {
    // The ID number for this group order
    var id: Int
    
    // The type of group order.
    var groupOrderType: OrderType
    
    // The cumulative estimated commission for this group order
    var cumulativeEstimatedCommission: Double
    
    // The cumulative estimated fee for this group order
    var cumulativeEstimatedFees: Double
    
    // Container for information on an order
    var order: Order
    
    init(object: MarshaledObject) throws {
        id = try object.value(for: "groupOrderId")
        groupOrderType = try object.value(for: "groupOrderType")
        cumulativeEstimatedCommission = try object.value(for: "cumulativeEstimatedCommission")
        cumulativeEstimatedFees = try object.value(for: "cumulativeEstimatedFees")
        order = try object.value(for: "order")
    }
}
