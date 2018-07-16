//
//  Quote.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/13/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Marshal

struct Quote: Unmarshaling {
    // Indicates whether an option has been adjusted due to a corporate action (e.g. a dividend or stock split)
    var adjNonAdjFlag: Bool?
    
    // Cash amount paid per share over the past year
    var annualDividend: Double?
    
    // The current ask price for a security
    var ask: Double?
    
    // Code for the exchange reporting the ask price
    var askExchange: Exchange?

    // Number of shares or contracts offered by a broker/dealer at the ask price
    var askSize: Int?
    
    // Time of the ask, e.g., "15:15:43 EDT 03-15-2011"
    var askTime: String?
    
    // Current bid price for a security
    var bid: Double?
    
    // Code for the exchange reporting the bid price
    var bidExchange: Exchange?

    // Number of shares or contracts offered at the bid price
    var bidSize: Int?
    
    // Time of the bid, e.g., "15:15:43 EDT 03-15-2011"
    var bidTime: String?
    
    // Dollar change of the last price from the previous close
    var chgClose: Double?
    
    // Percentage change of the last price from the previous close
    var chgClosePrcn: Double?
    
    // Name of the company or mutual fund (Shows up to 40 characters)
    var companyName: String?
    
    // Number of days before the option expires
    var daysToExpiration: Int?
    
    // Direction of movement, i.e., whether the current price is higher or lower than the price of the most recent trade
    var dirLast: MarketMovementDirection?
    
    // Cash amount per share of the latest dividend
    var dividend: Double?

    // Earnings per share on a rolling basis (Stocks only)
    var eps: Double?

    // Projected earnings per share for the next fiscal year (Stocks only)
    var estEarnings: Double?

    // Date on which shareholders were entitled to receive the latest dividend, in epoch time
    var exDivDate: String?

    // Code for the exchange of the last trade.
    var exchgLastTrade: Exchange?

    // Financial Status Indicator - indicates whether a Nasdaqlisted issuer has failed to submit its regulatory
    //  filings on a timely basis, failed to meet continuing listing standards, and/or filed for bankruptcy
    var fsi: FinancialStatusIndicator?

    // Highest price at which a security has traded during the current day
    var high: Double?

    // Highest price at which a security has traded during the past year (52 weeks). For options, this value is the lifetime high.
    var high52: Double?

    // Highest ask price for the current trading day
    var highAsk: Double?

    // Highest bid price for the current trading day
    var highBid: Double?

    // Price of the most recent trade in a security
    var lastTrade: Double

    // Lowest price at which a security has traded during the current day
    var low: Double?

    // Lowest price at which a security has traded during the past year (52 weeks). For options, this value is the lifetime low.
    var low52: Double?

    // Lowest ask price for the current trading day
    var lowAsk: Double?

    // Lowest bid price for the current trading day
    var lowBid: Double?

    // Number of transactions that involve buying a security from another entity
    var numTrades: Int?

    // Price of a security at the current day's market open
    var open: Double?

    // Total number of options or futures contracts that are not closed or delivered on a particular day
    var openInterest: Double?

    // Specifies how the contract treats the expiration date.
    var optionStyle: OptionStyle?

    // Symbol for the underlier (Options only)
    var optionUnderlier: String?

    // Official price at the close of the previous trading day
    var prevClose: Double?

    // Final volume from the previous market session
    var prevDayVolume: Int?

    // Exchange code of the primary listing exchange for this instrument
    var primaryExchange: Exchange?

    // Description of the security - e.g., the company name or option description
    var symbolDesc: String?

    // Price at the close of the regular trading session for the current day
    var todayClose: Double?

    // Total number of shares or contracts exchanging hands
    var totalVolume: Int?

    // Uniform Practice Code - identifies specific FINRA advisories detailing unusual circumstances
    // (e.g., extremely large dividends, when-issued settlement dates, and worthless securities)
    var upc: Int?

    // Ten-day average trading volume for the security
    var volume10Day: Int?

    // Time of this quote, e.g., "15:15:43 EDT 03-15-2011"
    var dateTime: String
    
    // Product
    var product: Product
    
    init(object: MarshaledObject) throws {
        let dynamicKey = ((object as! MarshalDictionary).keys).first(where: { !(["dateTime","product"].contains($0)) })!
        
        adjNonAdjFlag = try? object.value(for: dynamicKey + ".adjNonAdjFlag")
        annualDividend = try? object.value(for: dynamicKey + ".annualDividend")
        ask = try? object.value(for: dynamicKey + ".ask")
        askExchange = try? object.value(for: dynamicKey + ".askExchange")
        askSize = try? object.value(for: dynamicKey + ".askSize")
        askTime = try? object.value(for: dynamicKey + ".askTime")
        bid = try? object.value(for: dynamicKey + ".bid")
        bidExchange = try? object.value(for: dynamicKey + ".bidExchange")
        bidSize = try? object.value(for: dynamicKey + ".bidSize")
        bidTime = try? object.value(for: dynamicKey + ".bidTime")
        chgClose = try? object.value(for: dynamicKey + ".chgClose")
        chgClosePrcn = try? object.value(for: dynamicKey + ".chgClosePrcn")
        companyName = try? object.value(for: dynamicKey + ".companyName")
        daysToExpiration = try? object.value(for: dynamicKey + ".daysToExpiration")
        dirLast = try? object.value(for: dynamicKey + ".dirLast")
        dividend = try? object.value(for: dynamicKey + ".dividend")
        eps = try? object.value(for: dynamicKey + ".eps")
        estEarnings = try? object.value(for: dynamicKey + ".estEarnings")
        exDivDate = try? object.value(for: dynamicKey + ".exDivDate")
        exchgLastTrade = try? object.value(for: dynamicKey + ".exchgLastTrade")
        fsi = try? object.value(for: dynamicKey + ".fsi")
        high = try? object.value(for: dynamicKey + ".high")
        high52 = try? object.value(for: dynamicKey + ".high52")
        highAsk = try? object.value(for: dynamicKey + ".highAsk")
        highBid = try? object.value(for: dynamicKey + ".highBid")
        lastTrade = try object.value(for: dynamicKey + ".lastTrade")
        low = try? object.value(for: dynamicKey + ".low")
        low52 = try? object.value(for: dynamicKey + ".low52")
        lowAsk = try? object.value(for: dynamicKey + ".lowAsk")
        lowBid = try? object.value(for: dynamicKey + ".lowBid")
        numTrades = try? object.value(for: dynamicKey + ".numTrades")
        open = try? object.value(for: dynamicKey + ".open")
        openInterest = try? object.value(for: dynamicKey + ".openInterest")
        optionStyle = try? object.value(for: dynamicKey + ".optionStyle")
        optionUnderlier = try? object.value(for: dynamicKey + ".optionUnderlier")
        prevClose = try? object.value(for: dynamicKey + ".prevClose")
        prevDayVolume = try? object.value(for: dynamicKey + ".prevDayVolume")
        primaryExchange = try? object.value(for: dynamicKey + ".primaryExchange")
        symbolDesc = try? object.value(for: dynamicKey + ".symbolDesc")
        todayClose = try? object.value(for: dynamicKey + ".todayClose")
        totalVolume = try? object.value(for: dynamicKey + ".totalVolume")
        upc = try? object.value(for: dynamicKey + ".upc")
        volume10Day = try? object.value(for: dynamicKey + ".volume10Day")
        dateTime = try object.value(for: "dateTime")
        product = try object.value(for: "product")
    }
}
