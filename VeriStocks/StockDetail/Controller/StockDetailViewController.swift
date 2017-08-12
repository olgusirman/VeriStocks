//
//  StockDetailViewController.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 12/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit

final class StockDetailViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var symbol: UILabel!          //Sembol
    @IBOutlet weak var price: UILabel!               //price
    @IBOutlet weak var difference: UILabel!          //difference
    @IBOutlet weak var differenceDirection: UIImageView! //d. Sıfırdan büyük ise yeşil, degisim okla yada renkle
    @IBOutlet weak var volume: UILabel!              //Hacim
    @IBOutlet weak var dayPeakPrice: UILabel!        //dayPeakPrice
    @IBOutlet weak var dayLowestPrice: UILabel!      //dayLowestPrice
    @IBOutlet weak var total: UILabel!               //total -> Adet
    @IBOutlet weak var lastPrice: UILabel!           // get the list Last price ( I think )
    
    /*
     a. Sembol
     b. Fiyat
     c. Değişim(%)
     d. Sıfırdan büyük ise yeşil, küçük ise kırmızı ile gösterilir.
     e. Günlük Yüksek
     f. Günlük Düşük
     g. Son
     h. Hacim
     i. Adet
     */
    
    var responseList : ResponseList?
    var selectedPeriod : StockPeriod?
    
    //MARK: Lifecycle 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let symbol = responseList?.symbol else { return }
        
        debugPrint("\(StockDetailViewController.self) \(#function) \(symbol)")
        
        APIManager().getStockDetail(symbol: symbol, period: selectedPeriod) { (stockResult) in
            
            //UpdateUI
            if let lastGraphic = stockResult.graphicList.last {
                self.updateUI(responseList: self.responseList, lastStock: lastGraphic)
            } else {
                //TODO: graph olmadigini belli eden birsey yapmali🤔
                self.updateUI(responseList: self.responseList)
            }
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Helper

    private func updateUI(responseList : ResponseList?, lastStock : StockGraphic? = nil ) {
        
        if let lastGraphPrice = lastStock?.price {
            self.lastPrice.text = "\(lastGraphPrice)"
        }
        
        if let responseList = responseList {
            configure(response: responseList)
        }
        
    }
    
    private func configure( response : ResponseList) {
        
        //symbolDirection
        
        if let symbol = response.symbol {
            self.symbol.text = symbol
        }
        
        if let price = response.price {
            self.price.text = "\(price)"
        }
        
        if let difference = response.difference {
            
            if difference >= 0 {
                differenceDirection.image = #imageLiteral(resourceName: "upArrow")
            } else {
                differenceDirection.image = #imageLiteral(resourceName: "downArrow")
            }
            
            self.difference.text = "%\(difference)"
        }
        
        if let volume = response.volume {
            self.volume.text = "\(volume)"
        }
        
        if let dayPeakPrice = response.dayPeakPrice {
            self.dayPeakPrice.text = "\(dayPeakPrice)"
        }
        
        if let dayLowestPrice = response.dayLowestPrice {
            self.dayLowestPrice.text = "\(dayLowestPrice)"
        }
        
        if let total = response.total {
            self.total.text = "\(total)"
        }
        
        
    }
    
    
}
