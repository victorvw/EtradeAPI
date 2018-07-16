//
//  EtradeApi.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/7/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift
import Marshal

final class EtradeApi {
    // MARK: - Private Properties
    private let oauthConsumerKey: String
    private let sessionManager: ApiManagerProtocol
    
    // MARK: - Designated Initializer
    init(oauthConsumerKey: String, oauthConsumerSecret: String, sessionManager: ApiManagerProtocol = SessionManager.default) {
        self.oauthConsumerKey = oauthConsumerKey
        self.sessionManager = sessionManager
        if let sessionManager = self.sessionManager as? SessionManager, sessionManager.adapter == nil {
            sessionManager.adapter = OauthAuthorizationAdapter(consumerKey: oauthConsumerKey, consumerSecret: oauthConsumerSecret)
        }
    }
    
    // MARK: - Public Methods
    // MARK: - Authorization API
    func getRequestToken(completionHandler: @escaping (ApiResult<String>) -> Void) {
        ((self.sessionManager as! SessionManager).adapter as! OauthAuthorizationAdapter).setHeaders(headers: ["oauth_callback": "oob"])
        
        _ = sessionManager.apiRequest(endpoint: .getRequestToken).apiResponseString { [unowned self] response in
            switch response.result {
            case .success(let responseValue):
                let responseParams = self.extractOauthTokenAndSecret(responseValue: responseValue)
                self.updateOauthTokenPair(oauthToken: responseParams.oauthToken, oauthTokenSecret: responseParams.oauthTokenSecret)
                completionHandler(ApiResult { return responseParams.oauthToken })
            case .failure(let error):
                completionHandler(ApiResult{ throw error })
            }
        }
    }
    
    func getAuthorizeUrlString(_ oauthToken: String) -> String {
        return "https://us.etrade.com/e/t/etws/authorize?key=" + oauthConsumerKey + "&token=" + oauthToken
    }
    
    func getAccessToken(oauthVerifier: String, completionHandler: @escaping (ApiResult<Bool>) -> Void) {
        var headers = ((self.sessionManager as! SessionManager).adapter as! OauthAuthorizationAdapter).getHeaders()
        headers["oauth_verifier"] = oauthVerifier
        ((self.sessionManager as! SessionManager).adapter as! OauthAuthorizationAdapter).setHeaders(headers: headers)
        
        _ = sessionManager.apiRequest(endpoint: .getAccessToken).apiResponseString { response in
            switch response.result {
            case .success(let responseValue):
                let responseParams = self.extractOauthTokenAndSecret(responseValue: responseValue)
                self.updateOauthTokenPair(oauthToken: responseParams.oauthToken, oauthTokenSecret: responseParams.oauthTokenSecret)
                completionHandler(ApiResult { return true })
            case .failure(let error):
                completionHandler(ApiResult{ throw error })
            }
        }
    }
    
    func renewAccessToken(completionHandler: @escaping (ApiResult<Bool>) -> Void) {
        _ = sessionManager.apiRequest(endpoint: .renewAccessToken).apiResponseString { response in
            switch response.result {
            case .success(let responseValue):
                let responseParams = self.extractOauthTokenAndSecret(responseValue: responseValue)
                self.updateOauthTokenPair(oauthToken: responseParams.oauthToken, oauthTokenSecret: responseParams.oauthTokenSecret)
                completionHandler(ApiResult { return true })
            case .failure(let error):
                completionHandler(ApiResult{ throw error })
            }
        }
    }
    
    func revokeAccessToken(completionHandler: @escaping (ApiResult<Bool>) -> Void) {
        _ = sessionManager.apiRequest(endpoint: .revokeAccessToken).apiResponseString { response in
            switch response.result {
            case .success(_):
                completionHandler(ApiResult { return true })
            case .failure(let error):
                completionHandler(ApiResult{ throw error })
            }
        }
    }
    
    // MARK: - Accounts API
    func getAccountList(completionHandler: @escaping (ApiResult<Account>) -> Void) {
        let parameters: Parameters? = nil
        
        _ = sessionManager.apiRequest(endpoint: .getAccountList, parameters: parameters).apiResponseJSON { response in
            switch response.result {
            case .success(let responseValue):
                do {
                    if let marshaledJson = responseValue as? MarshaledObject {
                        let account: Account = try marshaledJson.value(for: "AccountBalanceResponse")
                        completionHandler(ApiResult{ return account })
                    }
                } catch let error {
                    completionHandler(ApiResult{ throw error })
                }
            case .failure(let error):
                completionHandler(ApiResult{ throw error })
            }
        }
    }
    
    func getAccountBalance(accountId: Int, completionHandler: @escaping (ApiResult<[Account]>) -> Void) {
        let parameters: Parameters? = nil
        
        _ = sessionManager.apiRequest(endpoint: .getAccountBalance(accountId), parameters: parameters).apiResponseJSON { response in
            switch response.result {
            case .success(let responseValue):
                do {
                    if let marshaledJson = responseValue as? MarshaledObject {
                        // API returns a key with a period in it, so split this to ensure mapping works correctly
                        let accountListResponse: MarshaledObject = try marshaledJson.value(for: "json.accountListResponse")
                        let accounts: [Account] = try accountListResponse.value(for: "response")
                        completionHandler(ApiResult{ return accounts })
                    }
                } catch let error {
                    completionHandler(ApiResult{ throw error })
                }
            case .failure(let error):
                completionHandler(ApiResult{ throw error })
            }
        }
    }
    
    func getAccountPositions() {
        // TODO: Implement (Equities and Options)
    }
    
    func getTransactionHistory() {
        // TODO: Implement
    }
    
    func getTransactionDetails() {
        // TODO: Implement
    }
    
    func getAlerts() {
        // TODO: Implement
    }
    
    func readAlert() {
        // TODO: Implement
    }
    
    func deleteAlert() {
        // TODO: Implement
    }
    
    // MARK: - Market API
    func getOptionChains(optionChainType: OptionChainType, expirationMonth: Int, expirationYear: Int, underlier: String, skipAdjusted: Bool = true, completionHandler: @escaping (ApiResult<OptionChain>) -> Void) {
        let parameters = ["chainType": optionChainType.rawValue,
                          "expirationMonth": String(describing: expirationMonth),
                          "expirationYear": String(describing: expirationYear),
                          "underlier": underlier,
                          "skipAdjusted": String(describing: skipAdjusted).uppercased()]
        
        let request = sessionManager.apiRequest(endpoint: .getOptionChains, parameters: parameters).apiResponseJSON { response in
            switch response.result {
            case .success(let responseValue):
                do {
                    if let marshaledJson = responseValue as? MarshaledObject {
                        let optionChain: OptionChain = try marshaledJson.value(for: "optionChainResponse")
                        completionHandler(ApiResult{ return optionChain })
                    }
                } catch let error {
                    completionHandler(ApiResult{ throw error })
                }
            case .failure(let error):
                completionHandler(ApiResult{ throw error })
            }
        }
        print(request)
    }
    
    func getOptionExpireDates(underlier: String, completionHandler: @escaping (ApiResult<[ExpireDate]>) -> Void) {
        let parameters = ["underlier": underlier]
        
        _ = sessionManager.apiRequest(endpoint: .getOptionExpireDates, parameters: parameters).apiResponseJSON { response in
            switch response.result {
            case .success(let responseValue):
                do {
                    if let marshaledJson = responseValue as? MarshaledObject {
                        let expireDates: [ExpireDate] = try marshaledJson.value(for: "optionExpireDateGetResponse.expireDates")
                        completionHandler(ApiResult{ return expireDates })
                    }
                } catch let error {
                    completionHandler(ApiResult{ throw error })
                }
            case .failure(let error):
                completionHandler(ApiResult{ throw error })
            }
        }
    }
    
    func getProduct(company: String, securityType: SecurityType, completionHandler: @escaping (ApiResult<[Product]>) -> Void) {
        let parameters = ["company": company,
                          "type": securityType.rawValue]
        
        _ = sessionManager.apiRequest(endpoint: .getProduct, parameters: parameters).apiResponseJSON { response in
            switch response.result {
            case .success(let responseValue):
                do {
                    if let marshaledJson = responseValue as? MarshaledObject {
                        let products: [Product] = try marshaledJson.value(for: "productLookupResponse.productList")
                        completionHandler(ApiResult{ return products })
                    }
                } catch let error {
                    completionHandler(ApiResult{ throw error })
                }
            case .failure(let error):
                completionHandler(ApiResult{ throw error })
            }
        }
    }
    
    // TODO: Implement for options
    func getQuote(symbols: [String], detailFlag: DetailFlag = .all, completionHandler: @escaping (ApiResult<[Quote]>) -> Void) {
        let parameters = ["detailFlag": detailFlag]
        
        _ = sessionManager.apiRequest(endpoint: .getQuote(symbols), parameters: parameters).apiResponseJSON { response in
            switch response.result {
            case .success(let responseValue):
                do {
                    if let marshaledJson = responseValue as? MarshaledObject {
                        var quotes: [Quote]
                        if symbols.count == 1 {
                            quotes = [try marshaledJson.value(for: "quoteResponse.quoteData")]
                        } else {
                            quotes = try marshaledJson.value(for: "quoteResponse.quoteData")
                        }
                        completionHandler(ApiResult{ return quotes })
                    }
                } catch let error {
                    completionHandler(ApiResult{ throw error })
                }
            case .failure(let error):
                completionHandler(ApiResult{ throw error })
            }
        }
    }
    
    // MARK: - Order API
    func getOrderList() {
        // TODO: Implement
    }
    
    func previewEquityOrder() {
        // TODO: Implement
    }
    
    func placeEquityOrder() {
        // TODO: Implement
    }
    
    func previewEquityOrderChange() {
        // TODO: Implement
    }
    
    func placeEquityOrderChange() {
        // TODO: Implement
    }
    
    func previewOptionOrder() {
        // TODO: Implement
    }
    
    func placeOptionOrder() {
        // TODO: Implement
    }
    
    func previewOptionOrderChange() {
        // TODO: Implement
    }
    
    func placeOptionOrderChange() {
        // TODO: Implement
    }
    
    func cancelOrder() {
        // TODO: Implement
    }
    
    // MARK: - Notifications API
    func getMessageList() {
        // TODO: Implement
    }
    
    // MARK: - Limits API
    func getRateLimitsStatus(module: EtradeModule, completionHandler: @escaping (ApiResult<RateLimitStatus>) -> Void) {
        if let oauthToken = ((self.sessionManager as! SessionManager).adapter as! OauthAuthorizationAdapter).getOauthToken() {
            let parameters = ["oauth_consumer_key": oauthConsumerKey,
                              "oauth_token": oauthToken,
                              "module": module.rawValue]
            
            _ = sessionManager.apiRequest(endpoint: .getRateLimitStatus, parameters: parameters).apiResponseJSON { response in
                switch response.result {
                case .success(let responseValue):
                    do {
                        if let marshaledJson = responseValue as? MarshaledObject {
                            let rateLimitStatus: RateLimitStatus = try marshaledJson.value(for: "RateLimitStatus")
                            completionHandler(ApiResult{ return rateLimitStatus })
                        }
                    } catch let error {
                        completionHandler(ApiResult{ throw error })
                    }
                case .failure(let error):
                    completionHandler(ApiResult{ throw error })
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func extractOauthTokenAndSecret(responseValue: String) -> (oauthToken: String, oauthTokenSecret: String) {
        var oauthToken: String?
        var oauthTokenSecret: String?
        
        let paramStrings = responseValue.components(separatedBy: "&")
        for paramString in paramStrings {
            let paramParts = paramString.components(separatedBy: "=")
            if paramParts[0] == "oauth_token" {
                oauthToken = String(describing: paramParts[1]).removingPercentEncoding
            } else if paramParts[0] == "oauth_token_secret" {
                oauthTokenSecret = String(describing: paramParts[1]).removingPercentEncoding
            }
        }
        
        return (oauthToken!, oauthTokenSecret!)
    }
    
    private func updateOauthTokenPair(oauthToken: String, oauthTokenSecret: String) {
        if let oauthAuthorizationAdapter = ((self.sessionManager as? SessionManager)?.adapter as? OauthAuthorizationAdapter) {
            oauthAuthorizationAdapter.setHeaders(headers: ["oauth_token": oauthToken])
            oauthAuthorizationAdapter.setOauthTokenSecret(oauthTokenSecret)
        }
    }
}
