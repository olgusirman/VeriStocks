//
//  StocksTitlesViewController.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 09/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit

final class StocksTitlesViewController: UIViewController {
    
    //MARK: Properties
    var stocksTitle : String?
    
    fileprivate enum CellIdentifier : String {
        case stocksTitle
    }
    
    fileprivate enum Segue : String {
        case titleList
    }
    
    var selectedPeriod : StockPeriod?
    
    fileprivate lazy var titles : [StockTitle] = []
    
    fileprivate lazy var responseList: [ResponseList] = []
    fileprivate var filteredResponseList: [ResponseList]?
    fileprivate var stockResult : StockResult?
    
    //MARK: UI
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI
        if let stocksTitle = stocksTitle {
            title = stocksTitle
        }
        
        //Data
        getData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Helper
    
    private func getData() {
        
        self.titles.removeAll()
        
        //Get Stocks with selectedPeriod
        APIManager().getStocks(period: selectedPeriod) { (stockResult) in
            self.stockResult = stockResult
        }
        
        
        //get the titles from manager
        StocksTitleManager.getStocksTitle { (stockTitles) in
            
            self.titles.append(contentsOf: stockTitles)
            
            //reload first section
            let firstIndexSet = IndexSet(integer: 0)
            tableView.reloadSections(firstIndexSet, with: .top)
            
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.titleList.rawValue {
            
            guard let controller = segue.destination as? StocksListViewController else { return }
            
            if let selectedStock = sender as? StockTitle {
                controller.selectedStock = selectedStock
            }
            
            controller.responseList = self.responseList
            controller.filteredResponseList = self.filteredResponseList
            controller.selectedPeriod = self.selectedPeriod
            
        }
        
    }
    
    
}

//MARK: UITableView DataSource - Delegate
extension StocksTitlesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.stocksTitle.rawValue, for: indexPath) as! StocksTitlesCell
        
        let stock = titles[indexPath.row]
        cell.configure(name: stock.name )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedStock = titles[indexPath.row]
        
        guard let stockResult = self.stockResult else { return }
        
        //UI
        ////
        DispatchQueue.global(qos: .userInteractive).async {
            
            switch selectedStock.type {
            case .general:
                
                let responseList = stockResult.responseList
                
                self.responseList = responseList
                self.filteredResponseList = responseList
                
            case .up:
                
                let responseList = stockResult.responseList.filter({ (responseList) -> Bool in
                    
                    if let difference = responseList.difference {
                        return difference >= 0
                    }
                    return true
                })
                
                self.responseList = responseList
                self.filteredResponseList = responseList
                
            case .down:
                
                let responseList = stockResult.responseList.filter({ (responseList) -> Bool in
                    
                    if let difference = responseList.difference {
                        return difference < 0
                    }
                    return true
                })
                
                self.responseList = responseList
                self.filteredResponseList = responseList
                
            case .IMKB30:
                
                //take that imkb30 companies and just list that cmopanies
                //let imkb30CompanySymbols = stockResult.imkb30.map({ $0.symbol })
                
                let responseList = stockResult.responseList.filter({
                    
                    for imkbCompany in stockResult.imkb30 {
                        
                        //symbols are checked
                        if let symbol = $0.symbol, let imkbCompanySymbol = imkbCompany.symbol, symbol == imkbCompanySymbol {
                            return true
                        }
                        
                    }
                    
                    return false
                    
                })
                
                
                self.responseList = responseList
                self.filteredResponseList = responseList
                
            case .IMKB50:
                
                let responseList = stockResult.responseList.filter({
                    
                    for imkbCompany in stockResult.imkb50 {
                        
                        //symbols are checked
                        if let symbol = $0.symbol, let imkbCompanySymbol = imkbCompany.symbol, symbol == imkbCompanySymbol {
                            return true
                        }
                        
                    }
                    
                    return false
                    
                })
                
                self.responseList = responseList
                self.filteredResponseList = responseList
                
            case .IMKB100:
                
                let responseList = stockResult.responseList.filter({
                    
                    for imkbCompany in stockResult.imkb100 {
                        
                        //symbols are checked
                        if let symbol = $0.symbol, let imkbCompanySymbol = imkbCompany.symbol, symbol == imkbCompanySymbol {
                            return true
                        }
                        
                    }
                    
                    return false
                    
                })
                
                self.responseList = responseList
                self.filteredResponseList = responseList
                
            }
            
            DispatchQueue.main.async {
                //    self.tableView.reloadData()
                self.performSegue(withIdentifier: Segue.titleList.rawValue, sender: selectedStock)
            }
            
        }
        
    }
    
}
