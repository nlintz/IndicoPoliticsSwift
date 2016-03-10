//
//  ViewController.swift
//  IndicoPolitics
//
//  Created by Nathan Lintz on 1/9/16.
//  Copyright © 2016 Nathan Lintz. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var barChartView: BarChartView!
    let indico = IndicoIO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        barChartView.descriptionText = ""
        setChart(["Left", "Right", "Green", "Libertarian"], values: [0.0, 0.0, 0.0, 0.0])
    }

    @IBAction func submitText(sender: UIButton) {
        indico.political(textView.text).then({politics in self.setChart(["Left", "Right", "Green", "Libertarian"], values: [politics.left, politics.right, politics.green, politics.libertarian])})
        textView.resignFirstResponder()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setChart(labels: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Political Sentiment")
        let chartData = BarChartData(xVals: labels, dataSet: chartDataSet)
        barChartView.data = chartData
    }

}

