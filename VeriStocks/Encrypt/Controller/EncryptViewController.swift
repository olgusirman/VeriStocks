//
//  EncryptViewController.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 09/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit

final class EncryptViewController: UIViewController {
    
    //MARK: Properties
    
    private enum Segue : String {
        case stocksTitle
    }
    
    fileprivate var isEncryptParsed = false
    
    //MARK: UI
    
    @IBOutlet weak var stocksLandingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Veripark".localizedUppercase
        
        let manager = APIManager()
        
        /*
        manager.getEncrypt { (encrypt) in
            
            if !encrypt.isEmpty {
                self.isEncryptParsed = true
            }
            
        }*/
        
        if let encrypt = manager.encrypt, !encrypt.isEmpty  {
            self.isEncryptParsed = true
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.stocksTitle.rawValue {
            if let controller = segue.destination as? StocksTitlesViewController {
                controller.stocksTitle = stocksLandingButton.titleLabel?.text
            }
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if isEncryptParsed {
            return true
        } else {
            self.alert(title: nil, message: "Devam edebilmeniz için Encrypt data gerekli")
            return false
        }
        
    }

}
