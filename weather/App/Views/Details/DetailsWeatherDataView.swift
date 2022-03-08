//
//  DetailsWeatherDataView.swift
//  weather
//
//  Created by Angad Singh Virk on 06/12/21.
//

import SwiftUI
import SwiftSpinner

struct DetailsWeatherDataView: View {
    // Arguments
    var humidity: Double
    var precipitation: Double
    var cloudCover: Double
    // State Variable
    @State var lastData: [String: Double] = [
        "humidity" : -1,
        "precipitation" : -1,
        "cloudCover" : -1
    ]
    // Body
    var body: some View {
        VStack {
            // Weather Card
            VStack(alignment: .leading) {
                HStack {
                    Image("Precipitation")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text("Precipitation: " + String(precipitation) + " %")
                }
                HStack {
                    Image("Humidity")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text("Humidity: " + String(humidity) + " %")
                }
                HStack {
                    Image("CloudCover")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text("Cloud Cover: " + String(cloudCover) + " %")
                }
            }
            .padding()
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.3))
            .cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color.white, lineWidth: 1))
            .offset(y: 10)
            // Highcharts Gauge Chart
            GaugeView(
                humidity: humidity,
                precipitation: precipitation,
                cloudCover: cloudCover
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }
        .background(Image("background").resizable()
                        .frame(width: 500, height: 720))
        .onAppear  {
            if (humidity != self.lastData["humidity"] ||
                precipitation != self.lastData["precipitation"] ||
                cloudCover != self.lastData["cloudCover"])
            {
                // Only show loading if we have fresh data
                SwiftSpinner.show(duration: 0.8, title: "Loading...")
                self.lastData["humidity"] = humidity
                self.lastData["precipitation"] = precipitation
                self.lastData["cloudCover"] = cloudCover
            }
        }
    }
}
