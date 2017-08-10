//
//  StocksResult.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 11/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation

class StocksResultParser : NSObject {
    
    var requestResult : RequestResult?
    
    var responseList : [ResponseList] = []
    var currentResponseList: ResponseList?
    
    var xmlParser: XMLParser?
    var xmlText = ""
    
    
    init(withXML xml: String) {
        if let data = xml.data(using: String.Encoding.utf8) {
            xmlParser = XMLParser(data: data)
        }
    }
    
    func parse() -> StockResult {
        xmlParser?.delegate = self
        xmlParser?.parse()
        
        return StockResult(requestResult: requestResult!, responseList: responseList)
    }
    
}

extension StocksResultParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        //temp string ini her seferinde parse a basladiginda clean
        xmlText = ""
        if elementName == "RequestResult" {
            requestResult = RequestResult()
        }
        
        if elementName == "StockandIndex" { //Prepare the object that for array
            currentResponseList = ResponseList()
            
        }
        
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        //RequestResult
        if elementName == "Success" {
            if let success = Bool(xmlText) { //TODO: check that Bool is not nil? or could not be casted from string?
                requestResult?.success = success
            }
        }
        
        if elementName == "Message" {
            requestResult?.message = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        //StockandIndex
        
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
            if let hour = Float(xmlText) {
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
            if let isIndex = Bool(xmlText) { //TODO: check that Bool is not nil?
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
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        xmlText += string
    }
    
}
