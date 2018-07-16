//
//  DetailFlag.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/24/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation

enum DetailFlag: String {
    // Instrument fundamentals and latest price
    case fundamental = "FUNDAMENTAL"
    
    // Performance for the current or most recent trading day
    case intraday = "INTRADAY"
    
    // Information on a given option offering
    case options = "OPTIONS"
    
    // 52-week high and low (highest high and lowest low)
    case week52 = "WEEK52"
    
    // All of the above information and more
    case all = "ALL"
}
