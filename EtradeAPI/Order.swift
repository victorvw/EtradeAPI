//
//  Order.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 2/18/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct Order: Unmarshaling {
    // ID number assigned to this order
    var id: Int
    
    // The time the order was placed, in epoch time
    var placedTime: Int
    
    // The time the order was executed, in epoch time
    var executedTime: Int?
    
    // Total cost or proceeds, including commission
    var value: Double
    
    // The current status of the order.
    var status: OrderStatus
    
    // The order type.
    var orderType: OrderType
    
    // Specifies the term for which the order is in effect.
    var term: OrderTerm
    
    // The type of pricing.
    var priceType: PriceType
    
    // The highest price at which to buy or the lowest price at which to sell if specified in a limit order
    var limitPrice: Double?
    
    // The designated boundary price for a stop order
    var stopPrice: Double?
    
    // The designated boundary price for a stop-limit order
    var stopLimitPrice: Double?
    
    // The exchange where the user requests that the order be executed.
    var routingDestination: RoutingDestination // Exchange?
    
    // The order ID of the order that was replaced by this order due to a change order request
    var replacedByOrderId: Int?
    
    // If TRUE, the transactions specified in the order must be executed all at once, or not at all.
    var allOrNone: Bool
    
    // The user's lower trigger price on a buy and upper trigger price on a sale
    var bracketLimitPrice: Double?
    
    // The initial stop price that was set when a trailing stop order was submitted
    var initialStopPrice: Double?
    
    // The current trailing value. For Trailing Stop Dollar orders, this is a fixed dollar amount. For Trailing Stop Percentage orders, this is the price reflected by the percentage selected.
    var trailPrice: Double?
    
    // The price that an advanced order will trigger. For example, if it's a $1 buy trailing stop, then the trigger price will be $1 above the last price.
    var triggerPrice: Double?
    
    // For a conditional order, the price the condition is being compared against
    var conditionPrice: Double?
    
    // For a conditional order, the symbol that the condition is competing against
    var conditionSymbol: String?
    
    // The type of comparison to be used in a conditional order
    var conditionType: ConditionType?
    
    // In a conditional order, the type of price being followed.
    var conditionFollowPrice: ConditionFollowPrice?
    
    // Container for information on one leg of an order. There is at least one of these legDetails elements in every Order record, and more than one in a multi-leg order.
    var legDetails: [LegDetail]!
    
    // The number of shares to be publicly displayed if this is a reserve order
    var reserveQuantity: Double?
    
    // Container for symbol information for this leg. An option order will contain all of the following items; an equity order will only contain symbol.
    var symbolInfo: SymbolInfo
    
    init(object: MarshaledObject) throws {
        id = try object.value(for: "orderId")
        placedTime = try object.value(for: "orderPlacedTime")
        executedTime = try? object.value(for: "orderExecutedTime")
        value = try object.value(for: "orderValue")
        status = try object.value(for: "orderStatus")
        orderType = try object.value(for: "orderType")
        term = try object.value(for: "orderTerm")
        priceType = try object.value(for: "priceType")
        limitPrice = try? object.value(for: "limitPrice")
        stopPrice = try? object.value(for: "stopPrice")
        stopLimitPrice = try? object.value(for: "stopLimitPrice")
        routingDestination = try object.value(for: "routingDestination")
        replacedByOrderId = try? object.value(for: "replacedByOrderId")
        allOrNone = try object.value(for: "allOrNone")
        bracketLimitPrice = try? object.value(for: "bracketLimitPrice")
        initialStopPrice = try? object.value(for: "initialStopPrice")
        trailPrice = try? object.value(for: "trailPrice")
        triggerPrice = try? object.value(for: "triggerPrice")
        conditionPrice = try? object.value(for: "conditionPrice")
        conditionSymbol = try? object.value(for: "conditionPrice")
        conditionType = try? object.value(for: "conditionType")
        conditionFollowPrice = try? object.value(for: "conditionFollowPrice")
        
        legDetails = try? object.value(for: "conditionFollowPrice")
        if legDetails == nil, let legDetail: LegDetail = try object.value(for: "legDetails") {
            self.legDetails = [legDetail]
        }
        
        reserveQuantity = try? object.value(for: "reserveQuantity")
        symbolInfo = try object.value(for: "symbolInfo")
    }
}
