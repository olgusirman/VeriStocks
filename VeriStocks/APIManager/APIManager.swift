//
//  APIManager.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 08/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation

final class APIManager {
    
    //    typealias success = ( ( _ responseObject : ResponseBase) -> Void )
    //    typealias failure = ( ( _ error : Error?, _ message : String? ) -> Void )
    
    //TODO: failure yerine throws kullanabilirsin
    
    enum Constant : String {
        case baseUrl = "http://mobileexam.veripark.com/mobileforeks/service.asmx"
        case encryptKey
    }
    
    var encrypt : String? {
        
        get {
            //TODO: get encrpyt keychain later
            if let encrypt = UserDefaults.standard.object(forKey: Constant.encryptKey.rawValue) as? String {
                debugPrint("encrypt => \(encrypt)")
                return encrypt
            } else {
                return nil
            }
            
        }
        set {
            //TODO: get encrpyt keychain later
            UserDefaults.standard.set(newValue, forKey: Constant.encryptKey.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    fileprivate lazy var now : String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd:MM:yyyy HH:mm"
        return formatter.string(from: Date())
    }()
    
    //TODO: 1) Encrypt
    
    func getEncrypt( encryptHandler : @escaping (_ encrypt : String) -> () ) {
        
        //TODO: handle url correctly
        //let url = try! URL(string: Constant.baseUrl.rawValue)?.asURL()
        
        let url = URL(string: Constant.baseUrl.rawValue)!
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField:"Content-Type")
        request.addValue("length", forHTTPHeaderField: "Content-Length")
        request.timeoutInterval = 60.0
        
        //request RequestIsValid29:01:2015 16:31
        let reqBodyParameter = "RequestIsValid\(now)"
        debugPrint(reqBodyParameter)
        
        let bodyStr = EncryptRequestBody(parameter: reqBodyParameter).xmlString()
        let bodyData = bodyStr.data(using: String.Encoding.utf8, allowLossyConversion: true)
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("\(String(describing: error))")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200  else {
                print("responseCode \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                return
            }
            
            if let data = data {
                if let xmlResponse: String = String(data: data, encoding: String.Encoding.utf8) {
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        let encryptParser = EncryptParser(withXML: xmlResponse)
                        let encrypt = encryptParser.parse()
                        print(encrypt)
                        
                        self.encrypt = encrypt
                        
                        DispatchQueue.main.async {
                            encryptHandler(encrypt)
                        }
                        
                    }
                    
                }
            }
            
            
        }
        
        task.resume()
        
        
    }
    
    func getStocks(period : StockPeriod? = nil, handler : @escaping (_ stockResult : StockResult) -> ()) {
        
        guard let encrypt = self.encrypt else {
            return
        }
        
        let url = URL(string: Constant.baseUrl.rawValue)!
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField:"Content-Type")
        request.addValue("length", forHTTPHeaderField: "Content-Length")
        request.timeoutInterval = 60.0
        
        let bodyStr = StocksRequestBody( encrypt: encrypt, period: period).xmlString()
        let bodyData = bodyStr.data(using: String.Encoding.utf8, allowLossyConversion: true)
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("\(String(describing: error))")
                return
            }
            
            //Continue if statusCode == 200
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200  else {
                print("responseCode \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                return
            }
            
            if let data = data {
                if let xmlResponse: String = String(data: data, encoding: String.Encoding.utf8) {
                    
                    //debugPrint(xmlResponse)
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        let stocksResultParser = StocksResultParser(withXML: xmlResponse)
                        let stockResult = stocksResultParser.parse()
                        
                        //                        debugPrint(stockResult)
                        
                        if let success = stockResult.requestResult.success, success {
                            DispatchQueue.main.async {
                                handler(stockResult)
                            }
                        }
                        
                        
                    }
                    
                }
            }
            
            
        }
        
        task.resume()
        
    }
    
    
    func getStockDetail( symbol : String, period : StockPeriod? = nil, handler : @escaping (_ stockResult : StockResult) -> ()) {
        
        guard let encrypt = self.encrypt else {
            return
        }
        
        let url = URL(string: Constant.baseUrl.rawValue)!
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField:"Content-Type")
        request.addValue("length", forHTTPHeaderField: "Content-Length")
        request.timeoutInterval = 60.0
        
        let bodyStr = StocksRequestBody( encrypt: encrypt, period: period).xmlString(symbol: symbol)
        let bodyData = bodyStr.data(using: String.Encoding.utf8, allowLossyConversion: true)
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("\(String(describing: error))")
                return
            }
            
            //Continue if statusCode == 200
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200  else {
                print("responseCode \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                return
            }
            
            if let data = data {
                if let xmlResponse: String = String(data: data, encoding: String.Encoding.utf8) {
                    
                    //debugPrint(xmlResponse)
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        let stocksResultParser = StocksResultParser(withXML: xmlResponse)
                        let stockResult = stocksResultParser.parse()
                        
                        //debugPrint(stockResult)
                        
                        if let success = stockResult.requestResult.success, success {
                            DispatchQueue.main.async {
                                handler(stockResult)
                            }
                        }
                        
                        
                    }
                    
                }
            }
            
            
        }
        
        task.resume()
        
    }
    
    
}
