//
//  Router.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 08/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation
import Alamofire

protocol RestEndpoint : URLRequestConvertible {
    var method : HTTPMethod { get }
    var path : String { get }
    var encoding : Alamofire.ParameterEncoding { get }
    func asURLRequest() throws -> URLRequest
}

enum Router : RestEndpoint {
    
    case clientAdd
    case updateToken( token : String )
    
    
    var method : HTTPMethod {
        switch self {
        case .clientAdd, .updateToken:
            return .get
        }
    }
    
    var path : String {
        switch self {
        case .clientAdd, .updateToken:
            return "/client/add"
        }
    }
    
    var encoding : ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let parameters : Parameters? = {
            
            switch self {
            case .clientAdd:
                let param : Parameters = ["":""]
                
                return param
            case .updateToken( let token ):
                
                let param : Parameters = [ "id" : "", "notificationToken" : token]
                return param
                
            default:
                return .none
            }
            
        }()
        
        let baseUrl = ""
        let url = try baseUrl.asURL()
        let requestUrl = try url.appendingPathComponent(path).asURL()
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        
        switch self {
        case .clientAdd, .updateToken:
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return try encoding.encode(request, with: parameters)
            
            //    return try encoding.encode(request, with: nil)
            
        }
        
        
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //return try encoding.encode(request, with: parameters)
        
    }
    
    
    
    
}
