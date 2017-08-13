//
//  StockDetailViewController.swift
//  VeriStocks
//
//  Created by Olgu Sirman on 12/08/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit
import SwiftChart

final class StockDetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var chart : Chart! {
        didSet {
            chart.delegate = self
        }
    }
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var differenceDirection: UIImageView!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var dayPeakPrice: UILabel!
    @IBOutlet weak var dayLowestPrice: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var lastPrice: UILabel!
    
    var responseList : ResponseList?
    var selectedPeriod : StockPeriod?
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let symbol = responseList?.symbol else { return }
        
        //debugPrint("\(StockDetailViewController.self) \(#function) \(symbol)")
        
        APIManager().getStockDetail(symbol: symbol, period: selectedPeriod) { (stockResult) in
            
            //UpdateUI
            if let lastGraphic = stockResult.graphicList.last {
                self.updateUI(responseList: self.responseList, lastStock: lastGraphic)
            } else {
                self.updateUI(responseList: self.responseList)
            }
            
            let graphicList = stockResult.graphicList
            self.configureChart(graphicList)
            
            
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Redraw chart on rotation
        chart.setNeedsDisplay()
        
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
    
    private func configureChart(_ graphicList : [StockGraphic]) {
        
        guard graphicList.count > 0 else { return }
        
        var datas : [(x: Float, y: Float)] = []
        var xLabels : [(Float,String)] = []
        
        for (index, graph) in graphicList.enumerated() {
            
            if let price = graph.price {
                datas.append((Float(index), price))
                debugPrint("\(price)")
            }
            
            if let time = graph.date {
                let timeDate = time.configureDate(selectedPeriod: self.selectedPeriod)
                xLabels.append((Float(index), timeDate ?? "?"))
                debugPrint("\(timeDate)")
            }
            
        }
        
        let series = ChartSeries(data : datas)
        
        //If dates less then 10, use less values to represent x-axis
        if xLabels.count > 10 {
            
            guard let first = xLabels.first else { return }
            guard let last  = xLabels.last else { return }
            
            let xLabelsMidCount = (xLabels.count / 2)
            let mid = xLabels[xLabelsMidCount]
            
            
            let xLabelsFiltered = [first,mid,last]
            chart.xLabels = xLabelsFiltered.map({ $0.0 })
            
            chart.xLabelsFormatter = { index, value in
                let dates = xLabelsFiltered.map({ $0.1 })
                return dates[index]
            }
            
        } else {
            
            let reversedXlabels = xLabels
            
            chart.xLabels = reversedXlabels.map({ $0.0 })
            chart.xLabelsFormatter = { index, value in
                
                let dates = reversedXlabels.map({ $0.1 })
                return dates[index]
            }
        }
        
        //chart.yLabelsOnRightSide = true
        chart.add(series)
        
    }
    
}

extension StockDetailViewController : ChartDelegate {
    
    func didTouchChart(_ chart: Chart, indexes: Array<Int?>, x: Float, left: CGFloat) {
        
        for (seriesIndex, dataIndex) in indexes.enumerated() {
            if let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex) {
                print("Touched series: \(seriesIndex): data index: \(dataIndex!); series value: \(value); x-axis value: \(x) (from left: \(left))")
            }
        }
        
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
}

extension String {
    
    func configureDate( selectedPeriod : StockPeriod? ) -> String? {
        
        //if day dd
        //if month dd/MM
        //Use dateFormatter change your dateFormat which period selected
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from:self) {
            
            if let selectedPeriod = selectedPeriod {
                switch selectedPeriod {
                case .day:
                    dateFormatter.dateFormat = "dd/MM"
                case .week:
                    dateFormatter.dateFormat = "dd/MM"
                case .month:
                    dateFormatter.dateFormat = "MM/yyyy"
                default:
                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                }
                
            }
            
            let dateString = dateFormatter.string(from:date)
            return dateString
            
        } else {
            return nil
        }
        
    }
    
}
