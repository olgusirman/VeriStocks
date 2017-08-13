//
//  StocksResult.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 11/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation

final class StocksResultParser : NSObject {
    
    enum FetchType {
        case imkb30
        case imkb50
        case imkb100
        case responseList
        case requestResult
        case graphic
    }
    
    var requestResult : RequestResult?
    
    var responseList : [ResponseList] = []
    var currentResponseList: ResponseList?
    
    var imkb30 : [IMKBObject] = []
    var imkb50 : [IMKBObject] = []
    var imkb100 : [IMKBObject] = []
    var currentImkb : IMKBObject?
    
    var graphicList : [StockGraphic] = []
    var currentGraphic : StockGraphic?
    
    var xmlParser: XMLParser?
    var xmlText = ""
    
    var fetchType : FetchType = .responseList
    
    init(withXML xml: String) {
        if let data = xml.data(using: String.Encoding.utf8) {
            xmlParser = XMLParser(data: data)
        }
    }
    
    func parse() -> StockResult {
        xmlParser?.delegate = self
        xmlParser?.parse()
        
        return StockResult(requestResult: requestResult!, responseList: responseList, imkb30: imkb30, imkb50: imkb50, imkb100: imkb100, graphicList: graphicList.reversed())
    }
    
}

extension StocksResultParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        //temp string ini her seferinde parse a basladiginda clean
        xmlText = ""
        
        //For fetch Type
        switch elementName {
        case "StocknIndexesResponseList":
            
            fetchType = .responseList
            
        case "RequestResult":
            
            fetchType = .requestResult
            
        case "IMKB100List":
            
            fetchType = .imkb100
            
        case "IMKB50List":
            
            fetchType = .imkb50
            
        case "IMKB30List":
            
            fetchType = .imkb30
        
        case "StocknIndexesGraphicInfos":
            
            fetchType = .graphic
            
        default: ()
        }
        
        
        if elementName == "RequestResult" {
            requestResult = RequestResult()
        }
        
        if elementName == "StockandIndex" { //Prepare the object that for array
            currentResponseList = ResponseList()
        }
        
        if elementName == "IMKB100" {
            currentImkb = IMKBObject()
        }
        
        if elementName == "IMKB50" {
            currentImkb = IMKBObject()
        }
        
        if elementName == "IMKB30" {
            currentImkb = IMKBObject()
        }
        
        if elementName == "StockandIndexGraphic" {
            currentGraphic = StockGraphic()
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        //RequestResult
        if fetchType == .requestResult {
            
            if elementName == "Success" {
                if let success = Bool(xmlText) {
                    requestResult?.success = success
                }
            }
            
            if elementName == "Message" {
                requestResult?.message = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        //StockandIndex
        
        if fetchType == .responseList {
            
            if elementName == "Symbol" {
                currentResponseList?.symbol = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            if elementName == "Price" {
                if let price = Float(xmlText) {
                    currentResponseList?.price = price
                }
            }
            
            if elementName == "Difference" {
                if let difference = Float(xmlText) {
                    currentResponseList?.difference = difference
                }
            }
            
            if elementName == "Volume" {
                if let volume = Float(xmlText) {
                    currentResponseList?.volume = volume
                }
            }
            if elementName == "Buying" {
                if let buying = Float(xmlText) {
                    currentResponseList?.buying = buying
                }
            }
            if elementName == "Selling" {
                if let selling = Float(xmlText) {
                    currentResponseList?.selling = selling
                }
            }
            if elementName == "Hour" {
                if let hour = Int(xmlText) {
                    currentResponseList?.hour = hour
                }
            }
            if elementName == "DayPeakPrice" {
                if let dayPeakPrice = Float(xmlText) {
                    currentResponseList?.dayPeakPrice = dayPeakPrice
                }
            }
            
            if elementName == "DayLowestPrice" {
                if let dayLowestPrice = Float(xmlText) {
                    currentResponseList?.dayLowestPrice = dayLowestPrice
                }
            }
            
            if elementName == "Total" {
                if let total = Float(xmlText) {
                    currentResponseList?.total = total
                }
            }
            
            if elementName == "IsIndex" {
                if let isIndex = Bool(xmlText) {
                    currentResponseList?.isIndex = isIndex
                }
            }
            
            if elementName == "Date" {
                currentResponseList?.date = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            if elementName == "StockandIndex" {
                if let response = currentResponseList {
                    responseList.append(response)
                }
            }
            
        }
        
        //IMKB
        
        if fetchType == .imkb30 {
            if elementName == "Symbol" {
                currentImkb?.symbol = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            if elementName == "Name" {
                currentImkb?.name = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            if elementName == "Gain" {
                if let gain = Float(xmlText) {
                    currentImkb?.gain = gain
                }
            }
            
            if elementName == "Fund" {
                if let fund = Float(xmlText) {
                    currentImkb?.fund = fund
                }
            }
            
            if elementName == "IMKB30" {
                if let currentImkb = currentImkb {
                    imkb30.append(currentImkb)
                }
            }
            
        }
        
        if fetchType == .imkb50 {
            
            if elementName == "Symbol" {
                currentImkb?.symbol = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            if elementName == "Name" {
                currentImkb?.name = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            if elementName == "Gain" {
                if let gain = Float(xmlText) {
                    currentImkb?.gain = gain
                }
            }
            
            if elementName == "Fund" {
                if let fund = Float(xmlText) {
                    currentImkb?.fund = fund
                }
            }
            
            if elementName == "IMKB50" {
                if let currentImkb = currentImkb {
                    imkb50.append(currentImkb)
                }
            }
            
        }
        
        if fetchType == .imkb100 {
            
            if elementName == "Symbol" {
                currentImkb?.symbol = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            if elementName == "Name" {
                currentImkb?.name = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            if elementName == "Gain" {
                if let gain = Float(xmlText) {
                    currentImkb?.gain = gain
                }
            }
            
            if elementName == "Fund" {
                if let fund = Float(xmlText) {
                    currentImkb?.fund = fund
                }
            }
            
            if elementName == "IMKB100" {
                if let currentImkb = currentImkb {
                    imkb100.append(currentImkb)
                }
            }
            
        }
        
        if fetchType == .graphic {
            
            if elementName == "Price" {
                if let price = Float(xmlText) {
                    currentGraphic?.price = price
                }
            }
            
            if elementName == "Date" {
                currentGraphic?.date = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            if elementName == "StockandIndexGraphic" {
                if let currentGraphic = currentGraphic {
                    graphicList.append(currentGraphic)
                }
            }
            
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        xmlText += string
    }
    
}
