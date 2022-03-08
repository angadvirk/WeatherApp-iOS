//
//  TwitterButton.swift
//  weather
//
//  Created by Angad Singh Virk on 08/12/21.
//

import SwiftUI

struct TwitterButton: View {
    // Arguments
    var cityName: String
    var intervals: [Interval]
    var temperature: Double
    var weatherCode: Int
    // Body
    var body: some View {
        if (intervals != [] &&
            temperature != .infinity &&
            weatherCode != -1) // Null Checking
        {
            Link(
                destination: URL(
                    string: constructTwitterURL(
                        cityName: cityName,
                        intervals: intervals,
                        temperature: temperature,
                        weatherCode: weatherCode
                    )
                )!,
                label: {
                    Image("Twitter")
                        .renderingMode(.template)
                        .foregroundColor(.blue)
                }
            )
        }
    }
}

private func constructTwitterURL(cityName: String, intervals: [Interval], temperature: Double,
                                 weatherCode: Int) -> String {
    // Formatting the date
    let isoDateFormatter = ISO8601DateFormatter() // To parse dates from ISO
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .full
    dateFormatter.timeStyle = .none
    dateFormatter.dateFormat = "dd MMMM, yyyy"
    let dateString = dateFormatter.string(
        from: isoDateFormatter.date(from: intervals.first!.startTime)!
    )
    // Constructing the URL
    var urlString = "https://twitter.com/intent/tweet?text=The%20temperature%20in%20"
    urlString += cityName.replacingOccurrences(of: " ", with: "%20") + "%20on%20"
    urlString += dateString.replacingOccurrences(of: " ", with: "%20") + "%20is%20"
    urlString += String(temperature) + "%20%C2%B0F%2E"
    urlString += "%20The%20weather%20conditions%20are%20"
    urlString += codeToStatus[weatherCode]!.replacingOccurrences(of: " ", with: "%20")
    urlString += "%2E&hashtags=CSCI571WeatherForecast"
    return urlString
}
