//
//  StocksRequestBody.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 10/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation
import UIKit

enum StockPeriod : String {
    case noGraphic = "NoGraphic"
    case fiveMinutes = "FiveMinutes"
    case sixtyMinutes = "SixtyMinutes"
    case day = "Day"
    case week = "Week"
    case month = "Month"
}

struct StocksRequestBody {
    
    var period : StockPeriod = .day
    var encrypt : String
    
    enum StockRequestType {
        case list
        case detail
    }
    
    init( encrypt : String, period : StockPeriod? = nil) {
        self.encrypt = encrypt
        
        if let period = period {
            self.period = period
        }
        
    }
    
    func xmlString( symbol : String? = nil ) -> String {
        
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad ? true : false
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "No device id"
        let deviceType = UIDevice.current.model
        
        
        var xml = ""
        
        xml += "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\">"
        xml += "<soapenv:Header/>"
        xml += "<soapenv:Body>"
        xml += "<tem:GetForexStocksandIndexesInfo>"
        xml += "<tem:request>"
        xml += "<tem:IsIPAD>\(isIpad)</tem:IsIPAD>"
        xml += "<tem:DeviceID>\(deviceId)</tem:DeviceID>"
        xml += "<tem:DeviceType>\(deviceType)</tem:DeviceType>"
        xml += "<tem:RequestKey>\(encrypt)</tem:RequestKey>"
        
        if let symbol = symbol {
            xml += "<tem:RequestedSymbol>\(symbol)</tem:RequestedSymbol>"
        }
        
        xml += "<tem:Period>\(period.rawValue)</tem:Period>"
        xml += "</tem:request>"
        xml += "</tem:GetForexStocksandIndexesInfo>"
        xml += "</soapenv:Body>"
        xml += "</soapenv:Envelope>"
        
        return xml
        
        
        
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
        
       
    }
    
    
}
