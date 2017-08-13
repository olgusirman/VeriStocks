//
//  Encrypt.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 09/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation

final class EncryptParser : NSObject {
    
    var encryptResult : String?
    
    var xmlParser: XMLParser?
    var xmlText = ""
    var currentEncryptResult : String?
    
    init(withXML xml: String) {
        if let data = xml.data(using: String.Encoding.utf8) {
            xmlParser = XMLParser(data: data)
        }
    }
    
    func parse() -> String {
        xmlParser?.delegate = self
        xmlParser?.parse()
        return encryptResult ?? "nil"
    }
    
}

extension EncryptParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        xmlText = ""
        if elementName == "EncryptResponse" { //Start with your object
            currentEncryptResult = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "EncryptResult" { //Map part
            currentEncryptResult = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if elementName == "EncryptResponse" {
            encryptResult = currentEncryptResult
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        xmlText += string
    }
    
}
