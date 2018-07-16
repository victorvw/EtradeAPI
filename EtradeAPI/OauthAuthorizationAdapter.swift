//
//  HeadersAdapter.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/12/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift

class OauthAuthorizationAdapter: RequestAdapter {
    private let consumerKey: String
    private let consumerSecret: String
    
    private var headers: [String:String]!
    private var oauthTokenSecret: String!
    
    init(consumerKey: String, consumerSecret: String) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        urlRequest.setValue(generateAuthorizationValue(urlRequest: urlRequest, headers: self.headers), forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
    
    func setHeaders(headers: [String:String]) {
        self.headers = headers
    }
    
    func getHeaders() -> [String: String] {
        return self.headers
    }
    
    func setOauthTokenSecret(_ oauthTokenSecret: String) {
        self.oauthTokenSecret = oauthTokenSecret
    }
    
    func getOauthToken() -> String? {
        return self.headers["oauth_token"]
    }
    
    private func generateAuthorizationValue(urlRequest: URLRequest, headers: [String:String]) -> String {
        let oauthHeaders = getOauthHeaders(for: urlRequest)
        let allowedCharacters = CharacterSet.alphanumerics.union(CharacterSet.init(charactersIn: "-._~"))
        var authorizationValue = ""
        
        for (key, value) in oauthHeaders {
            if !authorizationValue.isEmpty {
                authorizationValue += ","
            }
            authorizationValue += key + "=\"" + value.addingPercentEncoding(withAllowedCharacters: allowedCharacters)! + "\""
        }
        
        return "OAuth " + authorizationValue
    }
    
    private func getOauthHeaders(for urlRequest: URLRequest) -> [String:String] {
        var headers = getHeaders()
        
        headers["oauth_consumer_key"] = consumerKey
        headers["oauth_nonce"] = generateOauthNonce()
        headers["oauth_signature_method"] = "HMAC-SHA1"
        headers["oauth_timestamp"] = String(describing: Int(floor(Date().timeIntervalSince1970)))
        headers["oauth_signature"] = generateOauthSignature(for: urlRequest, headers: headers, oauthTokenSecret: self.oauthTokenSecret)
        
        return headers
    }
    
    private func generateOauthNonce() -> String? {
        let dataCount = 32
        var nonceData = Data(count: dataCount)
        let result = nonceData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, dataCount, $0)
        }
        
        return result == errSecSuccess ? nonceData.base64EncodedString() : nil
    }
    
    private func generateOauthSignature(for urlRequest: URLRequest, headers: [String:String], oauthTokenSecret: String?) -> String {
        var parameterString: String = ""
        var signatureBaseString = ""
        var signingKey = ""
        var signature = ""
        let allowedCharacters = CharacterSet.alphanumerics.union(CharacterSet.init(charactersIn: "-._~"))
        var headers = headers
        var url = urlRequest.url!.absoluteString
        
        if let urlParts = urlRequest.url?.absoluteString.split(separator: "?"), urlParts.count > 1 {
            let queryParams = urlParts[1].split(separator: "&")
            for queryParam in queryParams {
                let queryParamParts = queryParam.split(separator: "=")
                headers[String(describing: queryParamParts[0])] = String(describing: queryParamParts[1])
            }
            url = String(describing: urlParts[0])
        }
        
        for key in headers.keys.sorted() {
            if !parameterString.isEmpty {
                parameterString += "&"
            }
            parameterString += key + "=" + headers[key]!.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
        }
        
        signatureBaseString += urlRequest.httpMethod! + "&" + (url.addingPercentEncoding(withAllowedCharacters: allowedCharacters))!
        signatureBaseString += "&" + parameterString.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
        
        signingKey += consumerSecret + "&"
        
        if let oauthTokenSecret = oauthTokenSecret {
            signingKey += oauthTokenSecret.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
        }
        
        do {
            let signatureBaseStringBytes = Array(signatureBaseString.utf8)
            let signingKeyBytes = Array(signingKey.utf8)
            
            signature = try HMAC(key: signingKeyBytes, variant: .sha1).authenticate(signatureBaseStringBytes).toBase64()!
        } catch { }
        
        return signature
    }
}
