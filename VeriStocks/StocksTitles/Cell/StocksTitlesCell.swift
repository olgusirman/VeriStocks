//
//  StocksTitlesCell.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 09/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit

final class StocksTitlesCell: UITableViewCell {

    @IBOutlet weak var titleName: UILabel!
    
    func configure( name : String) {
        titleName.text = name
    }
    
}
