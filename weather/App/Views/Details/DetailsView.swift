//
//  DetailsView.swift
//  weather
//
//  Created by Angad Singh Virk on 06/12/21.
//

import SwiftUI
import SwiftSpinner

struct DetailsView: View {
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
    var cityName: String = ""
    var intervals: [Interval]
    // Body
    var body: some View {
        ZStack {
            Image("background").resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all)
            TabView {
                DetailsTodayView(
                    windSpeed: windSpeed,
                    pressure: pressure,
                    precipitation: precipitation,
                    temperature: temperature,
                    weatherCode: weatherCode,
                    humidity: humidity,
                    visibility: visibility,
                    cloudCover: cloudCover,
                    uvIndex: uvIndex)
                .tabItem {
                    Image("Today_Tab")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                    Text("TODAY")
                        .font(.title)
                }
                DetailsWeeklyView(
                    weatherCode: weatherCode,
                    temperature: temperature,
                    intervals: intervals)
                .tabItem {
                    Image("Weekly_Tab")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                    Text("WEEKLY")
                        .font(.title)
                }
                DetailsWeatherDataView(
                    humidity: humidity,
                    precipitation: precipitation,
                    cloudCover: cloudCover
                )
                .tabItem {
                    Image("Weather_Data_Tab")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                    Text("WEATHER DATA")
                        .font(.title)
                }
            }
            .accentColor(.blue)
        }
        .navigationTitle(cityName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: TwitterButton(
                cityName: cityName,
                intervals: intervals,
                temperature: temperature,
                weatherCode: weatherCode
            )
        )
    }
}
