//
//  AlertHelper.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 09/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert( title: String? = nil, message : String? = nil, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default, handler: handler)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
}
