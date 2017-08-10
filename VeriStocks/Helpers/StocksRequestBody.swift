//
//  StocksRequestBody.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 10/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation

enum StockPeriod : String {
    case noGraphic = "NoGraphic"
    case fiveMinutes = "FiveMinutes"
    case sixtyMinutes = "SixtyMinutes"
    case day = "Day"
    case week = "Week"
    case month = "Month"
}

struct StocksRequestBody {
    
    var parameter: String
    var period : StockPeriod = .day
    
    init(parameter: String, period : StockPeriod? = nil) {
        self.parameter = parameter
        
        if let period = period {
            self.period = period
        }
        
    }
    
    func xmlString() -> String {
        
        var xml = ""
        
        var isIPAD = true
        let DeviceID = ""
        let deviceType = "ipad"
        let encrypt = ""
        
        xml += "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\">"
        xml += "<soapenv:Header/>"
        xml += "<soapenv:Body>"
        xml += "<tem:GetForexStocksandIndexesInfo>"
        xml += "<tem:request>"
        xml += "<tem:IsIPAD>\(isIPAD)</tem:IsIPAD>"
        xml += "<tem:DeviceID>\(DeviceID)</tem:DeviceID>"
        xml += "<tem:DeviceType>\(deviceType)</tem:DeviceType>"
        xml += "<tem:RequestKey>\(encrypt)</tem:RequestKey>"
        xml += "<tem:Period>\(period)</tem:Period>"
        xml += "</tem:request>"
        xml += "</tem:GetForexStocksandIndexesInfo>"
        xml += "</soapenv:Body>"
        xml += "</soapenv:Envelope>"
        
        
        //For Another service body
        /*
        xml += "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        xml += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        xml += "<soap:Body>"
        xml += "<GetForexStocksandIndexesInfo xmlns=\"http://tempuri.org/\">"
        xml += "<request>"
        xml += "<RequestedSymbol>\(parameter)</RequestedSymbol>"
        xml += "<Period>\(period.rawValue)</Period>"
        xml += "</request>"
        xml += "</GetForexStocksandIndexesInfo>"
        xml += "</soap:Body>"
        xml += "</soap:Envelope>"
        */
        
        return xml
    }

    
}
