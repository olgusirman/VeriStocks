//
//  StockResult.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 11/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation

/*
 GetForexStocksandIndexesInfoResult;
             RequestResult;
                &lt;Success&gt;true&lt;/Success&gt;
                &lt;Message&gt;Request is successfully completed&lt;/Message&gt;
             &lt;/RequestResult&gt;
             &lt;StocknIndexesResponseList&gt;
                &lt;StockandIndex&gt;
                   &lt;Symbol&gt;MIPAZ&lt;/Symbol&gt;
                   &lt;Price&gt;1.33&lt;/Price&gt;
                   &lt;Difference&gt;0.02&lt;/Difference&gt;
                   &lt;Volume&gt;1851043.14&lt;/Volume&gt;
                   &lt;Buying&gt;1.32&lt;/Buying&gt;
                   &lt;Selling&gt;1.33&lt;/Selling&gt;
                   &lt;Hour&gt;173402&lt;/Hour&gt;
                   &lt;DayPeakPrice&gt;1.35&lt;/DayPeakPrice&gt;
                   &lt;DayLowestPrice&gt;1.31&lt;/DayLowestPrice&gt;
                   &lt;Total&gt;0&lt;/Total&gt;
                   &lt;IsIndex&gt;false&lt;/IsIndex&gt;
                &lt;/StockandIndex&gt;
 */

/*
 <Symbol>string</Symbol>
 <Price>decimal</Price>
 <Difference>decimal</Difference>
 <Volume>decimal</Volume>
 <Buying>decimal</Buying>
 <Selling>decimal</Selling>
 <Hour>string</Hour>
 <DayPeakPrice>decimal</DayPeakPrice>
 <DayLowestPrice>decimal</DayLowestPrice>
 <Total>decimal</Total>
 <IsIndex>boolean</IsIndex>
 <Date>string</Date>
 */

/*
 <IMKB100List>
 <IMKB100>
 <Symbol>string</Symbol>
 <Name>string</Name>
 <Gain>decimal</Gain>
 <Fund>decimal</Fund>
 </IMKB100>
 ...
 ...
 </IMKB100List>
 
 */

/*
 <IMKB50List>
 <IMKB50>
 <Symbol>string</Symbol>
 <Name>string</Name>
 <Gain>decimal</Gain>
 <Fund>decimal</Fund>
 </IMKB50>
 ...
 ...
 </IMKB50List>
 
 */

/*
 <IMKB30List>
 <IMKB30>
 <Symbol>string</Symbol>
 <Name>string</Name>
 <Gain>decimal</Gain>
 <Fund>decimal</Fund>
 </IMKB30>
 <IMKB30>
 <Symbol>string</Symbol>
 <Name>string</Name>
 <Gain>decimal</Gain>
 <Fund>decimal</Fund>
 </IMKB30>
 </IMKB30List>
 */

//GetForexStocksandIndexesInfoResult
struct StockResult {
    
    var requestResult : RequestResult   //RequestResult
    var responseList : [ResponseList]   //StocknIndexesResponseList
    var imkb30 : [IMKBObject]
    var imkb50 : [IMKBObject]
    var imkb100 : [IMKBObject]
    
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
