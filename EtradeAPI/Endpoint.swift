//
//  Endpoint.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/11/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint {
    case getRequestToken
    case getAccessToken
    case renewAccessToken
    case revokeAccessToken
    case getAccountBalance(Int)
    case getAccountList
    case getOptionChains
    case getOptionExpireDates
    case getProduct
    case getQuote([String])
    case getRateLimitStatus
    
    // MARK: - Public Properties
    var method: HTTPMethod {
        switch self {
        case .getRequestToken,
             .getAccessToken,
             .renewAccessToken,
             .revokeAccessToken,
             .getAccountBalance,
             .getAccountList,
             .getOptionChains,
             .getOptionExpireDates,
             .getProduct,
             .getQuote,
             .getRateLimitStatus:
            return .get
        }
    }
    
    var url: URL {
        let baseUrl = URL.getBaseUrl(self)
        
        switch self {
        case .getRequestToken:
            return baseUrl.appendingPathComponent("request_token")
        case .getAccessToken:
            return baseUrl.appendingPathComponent("access_token")
        case .renewAccessToken:
            return baseUrl.appendingPathComponent("renew_access_token")
        case .revokeAccessToken:
            return baseUrl.appendingPathComponent("revoke_access_token")
        case .getAccountBalance(let accountId):
            return baseUrl.appendingPathComponent("accountbalance/\(accountId)")
        case .getAccountList:
            return baseUrl.appendingPathComponent("accountlist")
        case .getOptionChains:
            return baseUrl.appendingPathComponent("optionchains")
        case .getOptionExpireDates:
            return baseUrl.appendingPathComponent("optionexpiredate")
        case .getProduct:
            return baseUrl.appendingPathComponent("productlookup")
        case .getQuote(let symbols):
            return baseUrl.appendingPathComponent("quote/" + symbols.joined(separator: ","))
        case .getRateLimitStatus:
            return baseUrl.appendingPathComponent("limits")
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getRequestToken,
             .getAccessToken,
             .renewAccessToken,
             .revokeAccessToken,
             .getAccountBalance,
             .getAccountList,
             .getOptionChains,
             .getOptionExpireDates,
             .getProduct,
             .getQuote,
             .getRateLimitStatus:
            return URLEncoding.default
        }
    }
}

private extension URL {
    static func getBaseUrl(_ endpoint: Endpoint) -> URL {
        let oauthBaseUrl = "https://etws.etrade.com/oauth/"
        let accountsBaseUrl = "https://etwssandbox.etrade.com/accounts/sandbox/rest/" // Production: "https://etws.etrade.com/accounts/rest/"
        let limitsBaseUrl = "https://etwssandbox.etrade.com/statuses/sandbox/rest/" // Production: "https://etws.etrade.com/statuses/rest/"
        let marketBaseUrl = "https://etwssandbox.etrade.com/market/sandbox/rest/" // Production: "https://etws.etrade.com/market/rest/"
        
        var urlString: String
        
        switch endpoint {
        case .getRequestToken,
             .getAccessToken,
             .renewAccessToken,
             .revokeAccessToken:
            urlString = oauthBaseUrl
        case .getAccountBalance,
             .getAccountList:
            urlString = accountsBaseUrl
        case .getOptionChains,
             .getOptionExpireDates,
             .getProduct,
             .getQuote:
            urlString = marketBaseUrl
        case .getRateLimitStatus:
            urlString = limitsBaseUrl
        }
        
        return URL(string: urlString)!
    }
}

