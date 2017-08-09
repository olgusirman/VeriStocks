//
//  StocksListViewController.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 09/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit

class StocksListViewController: UIViewController {
    
    //MARK: Properties
    
    //TODO: if selectedStock is Searchable, searchBar should be usable
    var selectedStock : StockTitle?

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }
    

}
