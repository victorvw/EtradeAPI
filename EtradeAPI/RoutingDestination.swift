//
//  RoutingDestination.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 2/18/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation

// TODO: This is likely a duplicate of Exchange, but with different values?
enum RoutingDestination: String {
    case auto = "AUTO"
    case americanStockExchange = "AMEX"
    case archipelago = "ARCA"
    case bostonOptionsExchange = "BOX"
    case chicagoBoardOptionsExchange = "CBOE"
    case nasdaq = "NSDQ"
    case nasdaqISE = "ISE"
    case nasdaqOptionsMarket = "NOM"
    case newYorkStockExchange = "NYSE"
    case philadelphiaStockExchange = "PHX"
}
