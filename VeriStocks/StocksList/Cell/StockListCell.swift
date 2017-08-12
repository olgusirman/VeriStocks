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
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var buying: UILabel!
    @IBOutlet weak var selling: UILabel!
    @IBOutlet weak var hour: UILabel!
    
    func configure( response : ResponseList) {
        
        //symbolDirection
        
        if let symbol = response.symbol {
            symbolName.text = symbol
        }
        
        if let price = response.price {
            self.price.text = "\(price)"
        }
        
        if let difference = response.difference {
            
            if difference >= 0 {
                symbolDirection.image = #imageLiteral(resourceName: "upArrow")
            } else {
                symbolDirection.image = #imageLiteral(resourceName: "downArrow")
            }
            
            self.difference.text = "%\(difference)"
        }
        
        if let volume = response.volume {
            self.volume.text = "\(volume)"
        }
        
        if let buying = response.buying {
            self.buying.text = "\(buying)"
        }
        
        if let selling = response.selling {
            self.selling.text = "\(selling)"
        }
        
        if let hour = response.hour {
            self.hour.text = hour.getTime()
        }
        
    }
    
    /*
     var symbol : String?         //Symbol
     var price : Float?           //Price
     var difference : Float?      //Difference
     var volume : Float?          //Volume
     var buying : Float?          //Buying
     var selling : Float?         //Selling
     var hour : Float?            //Hour
     
     var dayPeakPrice : Float?    //DayPeakPrice
     var dayLowestPrice : Float?  //DayLowestPrice
     var total : Float?           //Total
     var isIndex : Bool?          //IsIndex
     var date : String?           //Date
     */
    
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

extension Int {
    
    func getTime() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
        return "\(timeString)"
        
    }
    
}

extension Int {
    
    var toDecimal : String {
        
        let formatter = NumberFormatter()
        formatter.formatterBehavior = .behavior10_4
        formatter.locale = NSLocale.current
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.usesGroupingSeparator = true
        formatter.usesSignificantDigits = true
        
        formatter.groupingSeparator = ","
        formatter.maximumSignificantDigits = 4
        
        
        //        formatter.minimumSignificantDigits = 3
        
        if self >= 1000000 {
            let number = NSNumber(value: self)
            //            formatter.usesGroupingSeparator = false
            
            var formatterString = formatter.string(from: number)!
            formatterString.characters.removeLast()
            formatterString.characters.removeLast()
            //formatterString.characters.removeLast()
            
            return "\(formatterString) M"
            
        } else if self >= 10000 {
            
            formatter.groupingSeparator = "."
            
            let number = NSNumber(value: self)
            var formatterString = formatter.string(from: number)!
            formatterString.characters.removeLast()
            formatterString.characters.removeLast()
            
            return "\(formatterString) B"
            
        }
        
        let number = NSNumber(value: self)
        return formatter.string(from: number)!
        
    }
    
}
