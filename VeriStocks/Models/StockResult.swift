//
//  StockResult.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 11/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation

//I use struct, beacuse these objects are not LIVE, just represents values
struct StockResult {
    
    var requestResult : RequestResult   //RequestResult
    var responseList : [ResponseList]   //StocknIndexesResponseList
    var imkb30 : [IMKBObject]
    var imkb50 : [IMKBObject]
    var imkb100 : [IMKBObject]
    var graphicList : [StockGraphic]
    
}

struct RequestResult {
    var success : Bool?     //Success
    var message : String?   //Message
}

struct ResponseList {
    
    var symbol : String?         //Symbol
    var price : Float?           //Price
    var difference : Float?      //Difference
    var volume : Float?          //Volume
    var buying : Float?          //Buying
    var selling : Float?         //Selling
    var hour : Int?              //Hour
    var dayPeakPrice : Float?    //DayPeakPrice
    var dayLowestPrice : Float?  //DayLowestPrice
    var total : Float?           //Total
    var isIndex : Bool?          //IsIndex
    var date : String?           //Date
    
}

struct IMKBObject {
    var symbol : String?
    var name : String?
    var gain : Float?
    var fund : Float?
}

struct StockGraphic {
    var price : Float?
    var date : String?
}
