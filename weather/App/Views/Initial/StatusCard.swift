//
//  StatusCard.swift
//  weather
//
//  Created by Angad Singh Virk on 03/12/21.
//

import SwiftUI

struct StatusCard: View {
    // Arguments
    var temperature: Double
    var weatherCode: Int
    var cityName: String
    // Body
    var body: some View {
        HStack {
            Image(codeToStatus[weatherCode]!)
            VStack(alignment: .leading, spacing: 15.0) {
                Text(String(temperature) + "°F")
                    .font(.title)
                    .fontWeight(.heavy)
                Text(codeToStatus[weatherCode]!)
                    .font(.title3)
                Text(cityName)
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }.padding()
            .padding(.trailing, 5.0)
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.3))
            .cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color.white, lineWidth: 1))
    }
}

// Data structure to store all weather codes with their corresponding status names
var codeToStatus: [Int: String] = [
    0: "Unknown",
    3000: "Light Wind",
    3001: "Wind",
    3002: "Strong Wind",
    4201: "Heavy Rain",
    4001: "Rain",
    4200: "Light Rain",
    6201: "Heavy Freezing Rain",
    6001: "Freezing Rain",
    6200: "Light Freezing Rain",
    6000: "Freezing Drizzle",
    4000: "Drizzle",
    7101: "Heavy Ice Pellets",
    7000: "Ice Pellets",
    7102: "Light Ice Pellets",
    5101: "Heavy Snow",
    5000: "Snow",
    5100: "Light Snow",
    5001: "Flurries",
    8000: "Thunderstorm",
    2100: "Light Fog",
    2000: "Fog",
    1001: "Cloudy",
    1102: "Mostly Cloudy",
    1101: "Partly Cloudy",
    1100: "Mostly Clear",
    1000: "Clear"
]
