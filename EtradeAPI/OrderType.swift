//
//  OrderType.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 2/18/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation

enum OrderType: String {
    case eq = "EQ"
    case option = "OPTN"
    case advanceEq = "ADVANCE_EQ"
    case advanceOption = "ADVANCE_OPTN"
    case spreads = "SPREADS"
    case buyWrites = "BUY_WRITES"
    case contingent = "CONTINGENT"
    case oneCancelsAll = "ONE_CANCELS_ALL"
    case oneTriggersAll = "ONE_TRIGGERS_ALL"
    case oneTriggersOco = "ONE_TRIGGERS_OCO"
    case bracketed = "BRACKETED"
}
