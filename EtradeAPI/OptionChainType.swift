//
//  OptionChainType.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/24/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation

enum OptionChainType: String {
    case call = "CALL"
    
    case put = "PUT"
    
    // Calls and puts
    case callPut = "CALLPUT"
}
