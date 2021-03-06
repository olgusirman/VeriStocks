//
//  RequestBody.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 08/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation

struct EncryptRequestBody {
    
    var parameter: String
    
    init(parameter: String) {
        self.parameter = parameter
    }
    
    func xmlString() -> String {
        
        var xml = ""
        xml += "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        xml += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        xml += "<soap:Body>"
        xml += "<Encrypt xmlns=\"http://tempuri.org/\">"
        xml += "<request>\(parameter)</request>"
        xml += "</Encrypt>"
        xml += "</soap:Body>"
        xml += "</soap:Envelope>"
        
        return xml
    }
    
}
