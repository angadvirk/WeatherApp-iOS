//
//  GaugeView.swift
//  weather
//
//  Created by Angad Singh Virk on 07/12/21.
//

import Highcharts
import SwiftUI
import UIKit

struct GaugeIntegratedController: UIViewControllerRepresentable {
    var humidity: Double
    var precipitation: Double
    var cloudCover: Double
    func makeUIViewController(context: Context) -> GaugeViewController {
        let gvc = GaugeViewController()
        gvc.humidity = humidity
        gvc.precipitation = precipitation
        gvc.cloudCover = cloudCover
        return gvc
    }
    func updateUIViewController(_ uiViewController: GaugeViewController, context: Context) {
    }
}

struct GaugeView: View {
    var humidity: Double
    var precipitation: Double
    var cloudCover: Double
    var body: some View {
        GaugeIntegratedController(
            humidity: humidity,
            precipitation: precipitation,
            cloudCover: cloudCover)
    }
}

class GaugeViewController: UIViewController {
    // Data
    var humidity: Double = 0
    var precipitation: Double = 0
    var cloudCover: Double = 0
    
    override func viewDidLoad() {
        // Initial Setup
        super.viewDidLoad()
        // Chart Setup
        let chartView = HIChartView(frame: view.bounds)
        chartView.theme = "brand-light"
        chartView.plugins = ["solid-gauge"]
        let options = HIOptions()
        let chart = HIChart()
        chart.type = "solidgauge"
        chart.height = "110%"
        chart.width = 400
        options.chart = chart
        // Chart Title
        let title = HITitle()
        title.text = "Weather Data"
        title.style = HICSSObject()
        title.style.fontSize = "24px"
        options.title = title
        // Tooltip
        let tooltip = HITooltip()
        tooltip.borderWidth = 0
        tooltip.shadow = HIShadowOptionsObject()
        tooltip.shadow.opacity = 0
        tooltip.style = HICSSObject()
        tooltip.style.fontSize = "16px"
        tooltip.backgroundColor = HIColor(rgba: 255, green: 255, blue: 255, alpha: 0)
        tooltip.valueSuffix = "%"
        tooltip.pointFormat = "{series.name}<br><span style=\"font-size:2em; color: {point.color}; font-weight: bold\">{point.y}</span>"
        tooltip.positioner = HIFunction(jsFunction: "function (labelWidth) { return { x: (this.chart.chartWidth - labelWidth) / 2, y: (this.chart.plotHeight / 2) + 15 }; }")
        options.tooltip = tooltip
        // Pane (Backgrounds)
        let pane = HIPane()
        pane.startAngle = 0
        pane.endAngle = 360
        // 1
        let background1 = HIBackground()
        background1.backgroundColor = HIColor(rgba: 130, green: 238, blue: 106, alpha: 0.35)
        background1.outerRadius = "112%"
        background1.innerRadius = "88%"
        background1.borderWidth = 0
        // 2
        let background2 = HIBackground()
        background2.backgroundColor = HIColor(rgba: 106, green: 165, blue: 231, alpha: 0.35)
        background2.outerRadius = "87%"
        background2.innerRadius = "63%"
        background2.borderWidth = 0
        // 3
        let background3 = HIBackground()
        background3.backgroundColor = HIColor(rgba: 250, green: 88, blue: 95, alpha: 0.35)
        background3.outerRadius = "62%"
        background3.innerRadius = "38%"
        background3.borderWidth = 0
        // Done
        pane.background = [
          background1, background2, background3
        ]
        options.pane = pane
        // Y Axis
        let yAxis = HIYAxis()
        yAxis.min = 0
        yAxis.max = 100
        yAxis.lineWidth = 0
        yAxis.tickPositions = []
        options.yAxis = [yAxis]
        // Plot Options & Data
        let plotOptions = HIPlotOptions()
        plotOptions.solidgauge = HISolidgauge()
        let dataLabels = HIDataLabels()
        dataLabels.enabled = false
        plotOptions.solidgauge.dataLabels = [dataLabels]
        plotOptions.solidgauge.linecap = "round"
        plotOptions.solidgauge.stickyTracking = false
        plotOptions.solidgauge.rounded = true
        options.plotOptions = plotOptions
        // Cloud Cover
        let cloudCov = HISolidgauge()
        cloudCov.name = "Cloud Cover"
        let cloudCovData = HIData()
        cloudCovData.color = HIColor(rgba: 130, green: 238, blue: 106, alpha: 1)
        cloudCovData.radius = "112%"
        cloudCovData.innerRadius = "88%"
        cloudCovData.y = NSNumber(value: cloudCover)
        cloudCov.data = [cloudCovData]
        // Precipitation
        let precip = HISolidgauge()
        precip.name = "Precipitation"
        let precipData = HIData()
        precipData.color = HIColor(rgba: 106, green: 165, blue: 231, alpha: 1)
        precipData.radius = "87%"
        precipData.innerRadius = "63%"
        precipData.y = NSNumber(value: precipitation)
        precip.data = [precipData]
        // Humidity
        let hum = HISolidgauge()
        hum.name = "Humidity"
        let humData = HIData()
        humData.color = HIColor(rgba: 250, green: 88, blue: 95, alpha: 1)
        humData.radius = "62%"
        humData.innerRadius = "38%"
        humData.y = NSNumber(value: humidity)
        hum.data = [humData]
        // Final Steps
        options.series = [cloudCov, precip, hum]
        chartView.options = options
        // Display Chart
        self.view.addSubview(chartView)
      }

}
