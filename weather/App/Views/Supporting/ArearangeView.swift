//
//  ArearangeView.swift
//  weather
//
//  Created by Angad Singh Virk on 06/12/21.
//
import Highcharts
import SwiftUI
import UIKit

struct ArearangeIntegratedController: UIViewControllerRepresentable {
    var temperatures: [Any]
    func makeUIViewController(context: Context) -> ArearangeViewController {
        let avc = ArearangeViewController()
        avc.temperatures = temperatures
        return avc
    }
    func updateUIViewController(_ uiViewController: ArearangeViewController, context: Context) {
    }
}

struct ArearangeView: View {
    var temperatures: [Any]
    var body: some View {
        ArearangeIntegratedController(temperatures: temperatures)
    }
}

class ArearangeViewController: UIViewController {
    // Data
    var temperatures: [Any] = []

    override func viewDidLoad() {
        // Initial Setup
        super.viewDidLoad()
        // Chart Setup
        let chartView = HIChartView(frame: view.bounds)
        let options = HIOptions()
        let chart = HIChart()
        chart.type = "arearange"
        chart.height = 400
        chart.width = 400
        options.chart = chart
        // Chart Title
        let title = HITitle()
        title.text = "Temperature Variation by Day"
        options.title = title
        // X Axis
        let xAxis = HIXAxis()
        xAxis.type = "linear"
        xAxis.accessibility = HIAccessibility()
        xAxis.tickInterval = 5
        xAxis.crosshair = HICrosshair()
        options.xAxis = [xAxis]
        // Y Axis
        let yAxis = HIYAxis()
        yAxis.title = HITitle()
        yAxis.title.text = "Temperature"
        options.yAxis = [yAxis]
        // Tooltip (split)
        let tooltip = HITooltip()
        tooltip.shared = true
        tooltip.valueSuffix = "°F"
        tooltip.split = true
        options.tooltip = tooltip
        // Legend
        let legend = HILegend()
        legend.enabled = false
        options.legend = legend
        // Inserting Chart Data
        let tempArearange = HIArearange()
        tempArearange.name = "Temperatures"
        tempArearange.data = temperatures
        // Setting Colors
        tempArearange.color = HIColor(name: "black") // Point colors
        tempArearange.lineColor = HIColor(rgba: 255, green: 255, blue: 255, alpha: 0) // Line Color
        tempArearange.fillColor = HIColor( // Fill Color
            linearGradient: ["x1": 0, "y1": 0, "x2:": 0, "y2": 1],
            stops: [[0, "rgba(252, 180, 22, 1)"], [1, "rgba(106, 164, 231, 0.4)"]]
        )
        options.series = [tempArearange]
        chartView.options = options
        // Displaying Chart
        self.view.addSubview(chartView)
    }
}
