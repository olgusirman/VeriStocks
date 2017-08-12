//
//  StocksTitleManager.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 09/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation

final class StocksTitleManager {
    
    class func getStocksTitle( stocksTitle : (_ stocks : [StockTitle] ) -> () ) {
        
        var titles : [StockTitle] = []
        
        titles.append(StockTitle(name: "Hisse ve Endeksler", isSearchable: false, type: .general))
        titles.append(StockTitle(name: "IMKB Yükselenler", isSearchable: false, type: .up))
        titles.append(StockTitle(name: "IMKB Düşenler", isSearchable: false, type: .down))
        titles.append(StockTitle(name: "IMKB Hacme Göre - 30", isSearchable: false, type: .IMKB30))
        titles.append(StockTitle(name: "IMKB Hacme Göre - 50", isSearchable: false, type: .IMKB50))
        titles.append(StockTitle(name: "IMKB Hacme Göre - 100", isSearchable: true, type: .IMKB100))
        
        stocksTitle(titles)
        
    }
    
}
