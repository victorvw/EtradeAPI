//
//  OrderTerm.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 2/18/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation

enum OrderTerm: String {
    case goodUntilCancel = "GOOD_UNTIL_CANCEL"
    case goodForDay = "GOOD_FOR_DAY"
    case immediateOrCancel = "IMMEDIATE_OR_CANCEL"
    case fillOrKill = "FILL_OR_KILL"
}
