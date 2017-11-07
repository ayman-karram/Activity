//
//  ActivityViewController.swift
//  Activity
//
//  Created by Ayman  on 11/6/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import UIKit
import Charts

class ActivityViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var barChart: BarChartView!
    /**
     NSDictionary : KEY is activity Type and VALUE is Activities Array of this type. example ["Daily" : [Activities] , "Weekly" : [Activities]]
     */
    var userActivites : [String : [Activity]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationsObservers()
        getUserActivites()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helper Functions
    func getUserActivites () {
        self.userActivites = DataBaseManager.sharedInstance.getLoggedInUserActivites()
        setChart()
    }
    

    func  setChart () {
    
        let barWidth = 0.7

        // Customization
        barChart.chartDescription?.text = ""
        barChart.xAxis.labelPosition = .bottom
        barChart.leftAxis.axisMinimum = 0.0
        barChart.leftAxis.axisMaximum = 10.0
        barChart.rightAxis.enabled = false
        barChart.xAxis.drawGridLinesEnabled = true
        barChart.legend.enabled = true
        barChart.scaleYEnabled = true
        barChart.scaleXEnabled = true
        barChart.pinchZoomEnabled = true
        barChart.doubleTapToZoomEnabled = true
        barChart.highlighter = nil
        barChart.noDataText = ""
        
        // Initialize an array to store chart data entries (values; y axis)
        var salesEntries = [ChartDataEntry]()
        
        // Initialize an array to store months (labels; x axis)
        let activityTypes = ACTIVITESTAYPELIST
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:activityTypes)

        barChart.xAxis.granularity = 1
        
        for (index , activityTypeString) in activityTypes.enumerated() {
            // Create single chart data entry and append it to the array
            let activitesCount = Double ((self.userActivites![activityTypeString]?.count)!)
            let saleEntry = BarChartDataEntry(x: Double(index), y: activitesCount)
            salesEntries.append(saleEntry)
        }
        
        // Create bar chart data set containing salesEntries
        let chartDataSet = BarChartDataSet(values: salesEntries, label: "Activites")
        chartDataSet.colors = ChartColorTemplates.joyful()
        
        // Create bar chart data with data set and array with values for x axis
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        chartData.barWidth = barWidth
        
        // Set bar chart data to previously created data
        barChart.data = chartData
        
        // Animation
        barChart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
    }
    
    
    //MARK: - Notifications Center
    func addNotificationsObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.userDidAddNewActivity(notification:)), name: NSNotification.Name(rawValue: ADDEDNEWACTIVITYNOTIFICATIONNAME), object: nil)
    }
    
    @objc func userDidAddNewActivity (notification : NSNotification) {
        self.getUserActivites()
    }
}
