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
        
        titles.append(StockTitle(name: "Hisse ve Endeksler", isSearchable: false))
        titles.append(StockTitle(name: "IMKB Yükselenler", isSearchable: false))
        titles.append(StockTitle(name: "IMKB Düşenler", isSearchable: false))
        titles.append(StockTitle(name: "IMKB Hacme Göre - 30", isSearchable: false))
        titles.append(StockTitle(name: "IMKB Hacme Göre - 50", isSearchable: false))
        titles.append(StockTitle(name: "IMKB Hacme Göre - 100", isSearchable: true))
        
        stocksTitle(titles)
        
    }
    
}
