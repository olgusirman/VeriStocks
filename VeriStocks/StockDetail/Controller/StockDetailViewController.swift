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
    
    //TODO: bu sayfada adaptiveLayout kullanabilirsin reguler width e denk geldiginde sagli sollu kullanabilirsin
    //istersen stackView de deneyebilirsin, landscape oldugunda horizontal a cevirirsin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let symbol = responseList?.symbol else { return }
        
        debugPrint("\(StockDetailViewController.self) \(#function) \(symbol)")
        
        APIManager().getStockDetail(symbol: symbol, period: selectedPeriod) { (stockResult) in
            
            //UpdateUI
            if let lastGraphic = stockResult.graphicList.last {
                self.updateUI(responseList: self.responseList, lastStock: lastGraphic)
            } else {
                //TODO: graph olmadigini belli eden birsey yapmali🤔
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
        
        //symbolDirection
        
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
    
    private func convertDateFormater(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        guard let date = dateFormatter.date(from: date) else {
            //    assert(false, "no date from string")
            return ""
        }
        
        //2016-12-30T00:00:00
        
        dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
    private func configureChart(_ graphicList : [StockGraphic]) {
        
        //var datas : [Float] = []
//        var datas : [(x: Float, y: Float)] = [(x: 0.0, y: 0), (x: 3, y: 2.5), (x: 4, y: 2), (x: 5, y: 2.3), (x: 7, y: 3), (x: 8, y: 2.2), (x: 9, y: 2.5)]
        
        guard graphicList.count > 0 else { return }
        
        var datas : [(x: Float, y: Float)] = []
        
        var xLabels : [(Float,String)] = []
        
        for (index, graph) in graphicList.enumerated() {
            
            if let time = graph.date {
                
                //debugPrint(time)
                
                //if day dd
                //if month dd/MM
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                if let date = dateFormatter.date(from:time) {
                    
                    if let selectedPeriod = self.selectedPeriod {
                        switch selectedPeriod {
                        case .day:
                            
                            dateFormatter.dateFormat = "dd/MM"
                            
                        case .week:
                            
                            dateFormatter.dateFormat = "dd/MM"
                            
                        case .month:
                            
//                            dateFormatter.dateFormat = "M"
                            dateFormatter.dateFormat = "MM/yyyy"
                        default:
                            
                            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                        
                        }
                        
                    }
                    
                    //dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                    
                    let dateString = dateFormatter.string(from:date)
                    debugPrint(dateString)
                    xLabels.append((Float(index), dateString))
                    
                } else {
                    xLabels.append((Float(index), "?"))
                }
                
                
            }
            
            if let price = graph.price {
                //datas.append(price)
                datas.append((Float(index), price))
                
            }
            
        }
        
        
        
        //let series = ChartSeries(datas)
        let series = ChartSeries(data : datas)
        series.area = true
        //series.line = false
        //chart.maxX = 10
        //chart.maxX = 10
        //chart.minX = 0
        
        /*
        if xLabels.count >= 10 {
        
            let firstTen = xLabels.prefix(5)
            var firstTenXLabels = firstTen.map({ $0.0 })
            
            let lastTen = xLabels.suffix(5)
            let lastTenXLabels = lastTen.map({ $0.0 })
            
            firstTenXLabels.append(contentsOf: lastTenXLabels)
            
            chart.xLabels = firstTenXLabels
            
        } else {
            chart.xLabels = xLabels.map({ $0.0 })
        }
        */
        
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
            chart.xLabels = xLabels.map({ $0.0 })
            chart.xLabelsFormatter = { index, value in
                
                let dates = xLabels.map({ $0.1 })
                return dates[index]
            }
        }
        
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
