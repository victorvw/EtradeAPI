//
//  EtradeApiProtocol.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/11/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiManagerProtocol {
    func apiRequest(endpoint: Endpoint, parameters: Parameters?, headers: HTTPHeaders?) -> ApiRequestProtocol
}

extension ApiManagerProtocol {
    func apiRequest(endpoint: Endpoint) -> ApiRequestProtocol {
        return apiRequest(endpoint: endpoint, parameters: nil, headers: nil)
    }
    
    func apiRequest(endpoint: Endpoint, parameters: Parameters?) -> ApiRequestProtocol {
        return apiRequest(endpoint: endpoint, parameters: parameters, headers: nil)
    }
}

protocol ApiRequestProtocol {
    func apiResponseString(completionHandler: @escaping (DataResponse<String>) -> Void) -> Self
    func apiResponseJSON(completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self
}

extension SessionManager: ApiManagerProtocol {
    func apiRequest(endpoint: Endpoint, parameters: Parameters?, headers: HTTPHeaders?) -> ApiRequestProtocol {
        var headers = headers ?? HTTPHeaders()
        headers["Accept"] = "application/json"
        
        return request(endpoint.url, method: endpoint.method, parameters: parameters, encoding: endpoint.encoding, headers: headers)
    }
}

extension DataRequest: ApiRequestProtocol {
    func apiResponseString(completionHandler: @escaping (DataResponse<String>) -> Void) -> Self {
        return responseString(completionHandler: completionHandler)
    }
    
    func apiResponseJSON(completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
        return responseJSON(completionHandler: completionHandler)
    }
}
