//
//  OrderStatus.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 2/18/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation

enum OrderStatus: String {
    case open = "OPEN"
    case executed = "EXECUTED"
    case cancelled = "CANCELLED"
    case cancelRequested = "CANCEL_REQUESTED"
    case expired = "EXPIRED"
    case rejected = "REJECTED"
}
