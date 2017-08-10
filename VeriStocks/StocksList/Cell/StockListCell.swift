//
//  StockListCell.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 10/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit

class StockListCell: UITableViewCell {
    
    @IBOutlet weak var symbolDirection: UIImageView!
    @IBOutlet weak var symbolName: UILabel!
    @IBOutlet weak var symbolPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var buying: UILabel!
    @IBOutlet weak var selling: UILabel!
    @IBOutlet weak var hour: UILabel!
    
    func configure() {
        
    }
    
    //Ekranda gozukenler
    /*
     ok -> asagi yukari
     symbol isim -> symbol
     symbol altindaki sayi ?? ---> total
     fiyat -> Price
     %fark -> Difference
     islem hacmi -> Volume
     alis  -> Buying
     satis -> Selling
     saat -> Hour
     */
    
    
    /*
     DayPeakPrice
     DayLowestPrice
     Total
     isIndex : false
     */
    
}
