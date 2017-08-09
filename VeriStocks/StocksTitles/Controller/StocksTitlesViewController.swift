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
    
    fileprivate lazy var titles : [StockTitle] = []
    
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
            
            guard let controller = segue.destination as? StocksListViewController, let stock = sender as? StockTitle else { return }
            controller.selectedStock = stock
            
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
        cell.title = stock.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stock = titles[indexPath.row]
        performSegue(withIdentifier: Segue.titleList.rawValue, sender: stock)
        
    }
    
}
