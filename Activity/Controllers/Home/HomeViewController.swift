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
    var userActivites : [String : [Activity]]? // String key is activity type

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserActivites()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helper Functions
    func getUserActivites () {
        self.userActivites = DataBaseManager.sharedInstance.getLoggedInUserActivites()
        self.updateChartData()
    }
    
    func updateChartData()  {
        
        let chart = PieChartView(frame: self.view.frame)
        // 2. generate chart data entries
        let activitiesType = ACTIVITESTAYPELIST
        var count : [Double] = []

        for activityTypeString in activitiesType {
            let activityCount = self.userActivites![activityTypeString]!.count
            count.append(Double (activityCount))
        }
        
        var entries = [PieChartDataEntry]()
        for (index, value) in count.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = value
            entry.label = activitiesType[index]
            entries.append( entry)
        }
        
        // 3. chart setup
        let set = PieChartDataSet( values: entries, label: "Pie Chart")
        // this is custom extension method. Download the code for more details.
        var colors: [UIColor] = []
        
        for _ in 0..<count.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        set.colors = colors
        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.noDataText = ""
        chart.drawHoleEnabled = true
        chart.drawSlicesUnderHoleEnabled = true
        
        // user interaction
        chart.isUserInteractionEnabled = true
        
        let d = Description()
        d.text = "Activities depend on Type"
        chart.chartDescription = d
        chart.centerText = "Activites"
        chart.holeRadiusPercent = 0.2
        chart.transparentCircleColor = UIColor.clear
        self.view.addSubview(chart)
        
    }

}
