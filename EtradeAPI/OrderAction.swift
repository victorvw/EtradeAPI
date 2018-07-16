//
//  OrderAction.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 2/18/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation

enum OrderAction: String {
    case buy = "BUY"
    case sell = "SELL"
    case buyToCover = "BUY_TO_COVER"
    case sellShort = "SELL_SHORT"
    case buyOpen = "BUY_OPEN"
    case sellOpen = "SELL_OPEN"
    case buyClose = "BUY_CLOSE"
    case sellClose = "SELL_CLOSE"
}
