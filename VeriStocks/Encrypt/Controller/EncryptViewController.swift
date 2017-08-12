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
    @IBOutlet weak var pickerView: UIPickerView! {
        didSet {
            pickerView.dataSource = self
            pickerView.delegate = self
        }
    }
    
    fileprivate let stockPeriods : [StockPeriod] = [ .fiveMinutes, .sixtyMinutes, .day, .week, .month, .noGraphic ]
    fileprivate var selectedPeriod : StockPeriod?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Veripark".localizedUppercase
        
        encryptStatus()
        
        self.selectedPeriod = stockPeriods.first
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Helper
    
    private func encryptStatus() {
        
        let manager = APIManager()
        
        /* enrypt changes depends on period
         if let encrypt = manager.encrypt, !encrypt.isEmpty  {
         self.isEncryptParsed = true
         } else {
         manager.getEncrypt { (encrypt) in
         if !encrypt.isEmpty {
         self.isEncryptParsed = true
         }
         }
         }*/
        
        manager.getEncrypt { (encrypt) in
            if !encrypt.isEmpty {
                self.isEncryptParsed = true
            }
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.stocksTitle.rawValue {
            if let controller = segue.destination as? StocksTitlesViewController {
                controller.stocksTitle = stocksLandingButton.titleLabel?.text
                controller.selectedPeriod = self.selectedPeriod
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

extension EncryptViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stockPeriods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stockPeriods[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        debugPrint(stockPeriods[row].rawValue)
        self.selectedPeriod = stockPeriods[row]
        
    }
    
}
