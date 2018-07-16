//
//  FinancialStatusIndicator.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/15/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation

enum FinancialStatusIndicator: String {
    case deficient = "D"
    case delinquent = "E"
    case bankrupt = "Q"
    case normal = "N"
    case deficientAndBankrupt = "G"
    case deficientAndDelinquent = "H"
    case delinquentAndBankrupt = "J"
    case deficientDelinquentAndBankrupt = "K"
}
