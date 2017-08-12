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
    var selectedPeriod : StockPeriod?
    
    fileprivate enum CellIdentifier : String {
        case stockList
        case stockListSection
    }
    
    fileprivate enum Segue : String {
        case stockDetail
    }
    
    var responseList: [ResponseList] = []
    var filteredResponseList: [ResponseList]?
    fileprivate var searchController : UISearchController?
    
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
        
        
        let searchController = UISearchController(searchResultsController: nil)
        self.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        //UI
        if let selectedStock = selectedStock {
            
            title = selectedStock.name
            
            if selectedStock.isSearchable {
                
                //If selectedStock -> SearchBar must be added
                searchController.searchBar.searchBarStyle = .minimal
                tableView.tableHeaderView = searchController.searchBar
            }
        }
        
        //Data
//        getData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController?.dismiss(animated: false, completion: nil) //For clean dismiss
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Helper
    
    /*
    private func getData() {
        
        APIManager().getStocks { (stockResult) in
            
            //UI
            if let selectedStock = self.selectedStock {
                
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
                        
                        let responseList = stockResult.responseList
                        
                        self.responseList = responseList
                        self.filteredResponseList = responseList
                        
                    case .IMKB50:
                        
                        let responseList = stockResult.responseList
                        
                        self.responseList = responseList
                        self.filteredResponseList = responseList
                        
                    case .IMKB100:
                        
                        let responseList = stockResult.responseList
                        
                        self.responseList = responseList
                        self.filteredResponseList = responseList
                        
                    }
                    
                }
                
                //let indexSet = IndexSet(integer: 0)
                //self.tableView.reloadSections(indexSet, with: .automatic)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        }
        
    }
    */
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.stockDetail.rawValue {
            
            guard let controller = segue.destination as? StockDetailViewController, let responseList = sender as? ResponseList else { return }
            
            controller.responseList = responseList
            controller.selectedPeriod = self.selectedPeriod
            
        }
        
    }
    
    
}

//MARK: UITableView DataSource - Delegate
extension StocksListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filteredResponseList = filteredResponseList else {
            return 0
        }
        
        return filteredResponseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.stockList.rawValue, for: indexPath) as! StockListCell
        
        if let filteredResponseList = filteredResponseList {
            let filteredResponse = filteredResponseList[indexPath.row]
            cell.configure(response: filteredResponse)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let filteredResponseList = filteredResponseList {
            let filteredResponse = filteredResponseList[indexPath.row]
            
            debugPrint(filteredResponse)
            performSegue(withIdentifier: Segue.stockDetail.rawValue, sender: filteredResponse)
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.stockListSection.rawValue) as! StockListSectionCell
        
        return sectionCell
    }
    
}

extension StocksListViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredResponseList = responseList.filter { response in
                //return response.lowercased().contains(searchText.lowercased())
                if let symbol = response.symbol {
                    return symbol.lowercased().contains(searchText.lowercased())
                }
                
                return true
            }
            
        } else {
            filteredResponseList = responseList
        }
        tableView.reloadData()
    }
    
}
