//
//  DetailsWeeklyView.swift
//  weather
//
//  Created by Angad Singh Virk on 06/12/21.
//

import SwiftUI
import SwiftSpinner

struct DetailsWeeklyView: View {
    // Arguments
    var weatherCode: Int
    var temperature: Double
    var intervals: [Interval]
    // State Variable
    @State var lastIntervals: [Interval] = []
    // Body
    var body: some View {
        VStack {
            // Weather Card
            HStack {
                Image(codeToStatus[weatherCode]!)
                VStack {
                    Text(codeToStatus[weatherCode]!)
                        .font(.title)
                    Text(String(temperature) + "°F")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .padding()
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.3))
            .cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color.white, lineWidth: 1))
            .offset(y: 24)
            // Highcharts Arearange Chart
            ArearangeView(temperatures: constructTemperaturesArray(intervals: intervals))
                .padding(.horizontal)
                .padding(.top, 32)
        }
        .background(Image("background").resizable()
                        .frame(width: 500, height: 720))
        .onAppear  {
            if (intervals != self.lastIntervals) {
                // Only show loading if we have fresh data
                SwiftSpinner.show(duration: 0.8, title: "Loading...")
                self.lastIntervals = intervals
            }
        }
    }
}

private func constructTemperaturesArray(intervals: [Interval]) -> [Any] {
    // Variable
    var temperatures: [Any] = []
    // Function Body
    for i in 0...14 {
        temperatures.append([
            i,
            intervals[i].values?.temperatureMin as Any,
            intervals[i].values?.temperatureMax as Any
        ])
    }
    return temperatures
}
