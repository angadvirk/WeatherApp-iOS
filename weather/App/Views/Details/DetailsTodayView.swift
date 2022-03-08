//
//  DetailsTodayView.swift
//  weather
//
//  Created by Angad Singh Virk on 06/12/21.
//

import SwiftUI
import SwiftSpinner

struct DetailsTodayView: View {
    // Arguments
    var windSpeed: Double
    var pressure: Double
    var precipitation: Double
    var temperature: Double
    var weatherCode: Int
    var humidity: Double
    var visibility: Double
    var cloudCover: Double
    var uvIndex: Double
    // Body
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                DetailsCard(
                    imageName: "WindSpeed",
                    value: windSpeed,
                    metricName: "Wind Speed")
                DetailsCard(
                    imageName: "Pressure",
                    value: pressure,
                    metricName: "Pressure")
                DetailsCard(
                    imageName: "Precipitation",
                    value: precipitation,
                    metricName: "Precipitation")
            }
            HStack(spacing: 10) {
                DetailsCard(
                    imageName: "Temperature",
                    value: temperature,
                    metricName: "Temperature")
                DetailsCard(
                    imageName: codeToStatus[weatherCode]!,
                    metricName: codeToStatus[weatherCode]!)
                DetailsCard(
                    imageName: "Humidity",
                    value: humidity,
                    metricName: "Humidity")
            }.padding(.vertical, 48)
            HStack(spacing: 10) {
                DetailsCard(
                    imageName: "Visibility",
                    value: visibility,
                    metricName: "Visibility")
                DetailsCard(
                    imageName: "CloudCover",
                    value: cloudCover,
                    metricName: "Cloud Cover")
                DetailsCard(
                    imageName: "UVIndex",
                    value: Double(uvIndex),
                    metricName: "UVIndex")
            }
        }
        .background(Image("background").resizable()
                        .frame(width: 500, height: 720))
    }
}
