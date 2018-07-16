//
//  Exchange.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/15/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation

enum Exchange: String {
    case americanStockExchange = "A"
    case amexEmergingCompanyMarketplace = "G"
    case archipelago = "AP"
    case bats = "Z"
    case chicagoMidwestStockExchange = "M"
    case chicagoBoardOptionsExchange = "CO"
    case cincinnatiStockExchange = "C"
    case cincinnatiStockExchange2 = "CINC" // C is in the documentation, but CINC  is returned in the option chain mock
    case govPxBonds = "GP"
    case internationalSecuritiesExchangeOptions = "I"
    case island = "IS"
    case marketXt = "XT"
    case nasdaq = "NASDAQ" // Not sure which exchange this is per the documentation, but this is returned in the quote mock
    case nasdaqBulletinBoardTradesOnly = "V"
    case nasdaqMutualFundAndMoneyMarketFund = "F"
    case nasdaqNationalMarketSystem = "Q"
    case nasdaqNationalMarketSystem2 = "NASDAQ NM" // Q is in the documentation, but NASDAQ  is returned in the product lookup mock
    case nasdaqNationalMarketSystem3 = "NASDAQ National Market Sys (NMS)" // Q is in the documentation, but NASDAQ  is returned in the quote mock
    case nasdaqOmxBx = "B"
    case nasdaqOtcBulletinBoard = "U"
    case nasdaqOtcBulletinBoard2 = "OTCBB" // U is in the documentation, but OTCBB is returned in the product lookup mock
    case nasdaqSmallCap = "S"
    case nasdaqTradesInListedStocks = "T"
    case newYorkStockExchange = "N"
    case newYorkStockExchangeTradeReportingFacility = "R"
    case pacificStockExchangeTierI = "P"
    case pacificStockExchangeTierII = "PT"
    case philadelphiaStockExchange = "X"
    case redBook = "RD"
    case k = "K" // Not sure which exchange this is per the documentation, but this is returned in the quote mock
    case y = "Y" // Not sure which exchange this is per the documentation, but this is returned in the quote mock
}
