//
//  OptionStyle.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/15/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import Foundation

enum OptionStyle: String {
    // options can be exercised only on the expiration date
    case american = "American"
    
    // options can be exercised any time before it expires
    case european = "European"
}
