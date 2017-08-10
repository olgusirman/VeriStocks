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

    fileprivate enum CellIdentifier : String {
        case stockList
        case stockListSection
    }
    
    fileprivate enum Segue : String {
        case titleList
    }
    
    fileprivate lazy var titles : [String] = ["A","B","C","D","E","F"]
    fileprivate var filteredTitles: [String]?
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
        
        filteredTitles = titles

        let searchController = UISearchController(searchResultsController: nil)
        self.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        //UI
        if let selectedStock = selectedStock {
            if selectedStock.isSearchable {
                //SearchBar must be added
                searchController.searchBar.searchBarStyle = .minimal
                tableView.tableHeaderView = searchController.searchBar
            }
        }
        
        //Data
        //getData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController?.dismiss(animated: false, completion: nil) //For clean dismiss
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Helper
    
    private func getData() {
        
        //self.titles.removeAll()
        
        /*
        //get the titles from manager
        StocksTitleManager.getStocksTitle { (stockTitles) in
            
            self.titles.append(stockTitles)
            
            //reload first section
            let firstIndexSet = IndexSet(integer: 0)
            tableView.reloadSections(firstIndexSet, with: .top)
            
        }*/
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.titleList.rawValue {
            
//            guard let controller = segue.destination as? StocksListViewController, let stock = sender as? StockTitle else { return }
//            controller.selectedStock = stock
            
        }
        
    }
    

}

//MARK: UITableView DataSource - Delegate
extension StocksListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filtereTitles = filteredTitles else {
            return 0
        }
        
        return filtereTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.stockList.rawValue, for: indexPath) as! StockListCell
        
        if let filtereTitles = filteredTitles {
            let title = filtereTitles[indexPath.row]
            
            //TODO: configure and passData
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stock = titles[indexPath.row]
        //performSegue(withIdentifier: Segue.titleList.rawValue, sender: stock)
        debugPrint(stock)
        
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
            filteredTitles = titles.filter { title in
                return title.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            filteredTitles = titles
        }
        tableView.reloadData()
    }
    
}
