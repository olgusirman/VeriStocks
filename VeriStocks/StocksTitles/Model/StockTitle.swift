//
//  StockTitle.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 09/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation

struct StockTitle {
    
    enum `Type` {
        case general
        case up
        case down
        case IMKB30
        case IMKB50
        case IMKB100
    }
    
    var name: String
    var isSearchable : Bool
    var type : Type
}
