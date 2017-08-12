//
//  StockDetailViewController.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 12/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var symbolDirection: UIImageView!
    @IBOutlet weak var symbolName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var buying: UILabel!
    @IBOutlet weak var selling: UILabel!
    @IBOutlet weak var hour: UILabel!
    
    //MARK: Lifecycle 
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
