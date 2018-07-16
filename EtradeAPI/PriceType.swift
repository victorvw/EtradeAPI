//
//  PriceType.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 2/18/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation

enum PriceType: String {
    case market = "MARKET"
    case limit = "LIMIT"
    case stop = "STOP"
    case stopLimit = "STOP_LIMIT"
    case trailingStopConstantByLowerTrigger = "TRAILING_STOP_CNST_BY_LOWER_TRIGGER"
    case upperTriggerByTrailingStopConstant = "UPPER_TRIGGER_BY_TRAILING_STOP_CNST"
    case trailingStopPercentageByLowerTrigger = "TRAILING_STOP_PRCT_BY_LOWER_TRIGGER"
    case upperTriggerByTrailingStopPercentage = "UPPER_TRIGGER_BY_TRAILING_STOP_PRCT"
    case trailingStopConstant = "TRAILING_STOP_CNST"
    case trailingStopPercentage = "TRAILING_STOP_PRCT"
    case hiddenStop = "HIDDEN_STOP"
    case hiddenStopByLowerTrigger = "HIDDEN_STOP_BY_LOWER_TRIGGER"
    case upperTriggerByHiddenStop = "UPPER_TRIGGER_BY_HIDDEN_STOP"
    case netDebit = "NET_DEBIT"
    case netCredit = "NET_CREDIT"
    case netEven = "NET_EVEN"
    case marketOnOpen = "MARKET_ON_OPEN"
    case marketOnClose = "MARKET_ON_CLOSE"
    case limitOnOpen = "LIMIT_ON_OPEN"
    case limitOnClose = "LIMIT_ON_CLOSE"
}
