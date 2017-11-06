//
//  HomeViewController.swift
//  Activity
//
//  Created by Ayman  on 11/6/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var pieChartView: PieChartView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateChartData()  {
        
        let chart = PieChartView(frame: self.view.frame)
        // 2. generate chart data entries
        let track = ["Income", "Expense", "Wallet", "Bank"]
        let money = [1.0, 2.0, 0.0, 5.0]
        
        var entries = [PieChartDataEntry]()
        for (index, value) in money.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = value
            entry.label = track[index]
            entries.append( entry)
        }
        
        // 3. chart setup
        let set = PieChartDataSet( values: entries, label: "Pie Chart")
        // this is custom extension method. Download the code for more details.
        var colors: [UIColor] = []
        
        for _ in 0..<money.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        set.colors = colors
        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.noDataText = "No data available"
        // user interaction
        chart.isUserInteractionEnabled = true
        
        let d = Description()
        d.text = "iOSCharts.io"
        chart.chartDescription = d
        chart.centerText = "Pie Chart"
        chart.holeRadiusPercent = 0.2
        chart.transparentCircleColor = UIColor.clear
        self.view.addSubview(chart)
        
    }

}