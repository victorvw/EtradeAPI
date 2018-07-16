//
//  OptionPairType.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/24/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation

enum OptionPairType: String {
    case callOnly = "CALLONLY"
    
    case putOnly = "PUTONLY"
    
    // Calls and puts
    case callPut = "CALLPUT"
}
