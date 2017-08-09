//
//  EncryptViewController.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 09/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit

final class EncryptViewController: UIViewController {
    
    @IBOutlet weak var stocksLandingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Veripark".localizedUppercase
        
//        APIManager().getEncrypt()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        enum Segue : String {
            case stocksTitle
        }
        
        if segue.identifier == Segue.stocksTitle.rawValue {
            if let controller = segue.destination as? StocksTitlesViewController {
                controller.stocksTitle = stocksLandingButton.titleLabel?.text
            }
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        //TODO: if no encrpyt, no segue!
        
        return true
    }

}
