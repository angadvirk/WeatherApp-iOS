//
//  DetailsCard.swift
//  weather
//
//  Created by Angad Singh Virk on 06/12/21.
//

import SwiftUI

struct DetailsCard: View {
    // Arguments
    var imageName: String
    var value: Double?
    var metricName: String
    // Body
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
            if (value != nil) {
                if (metricName == "Wind Speed") {
                    Text(String(value!) + " mph")
                } else if (metricName == "Pressure") {
                    Text(String(value!) + " inHg")
                } else if (metricName == "Precipitation") {
                    Text(String(value!) + " %")
                } else if (metricName == "Temperature") {
                    Text(String(value!) + " °F")
                } else if (metricName == "Humidity") {
                    Text(String(value!) + " %")
                } else if (metricName == "Visibility") {
                    Text(String(value!) + " mi")
                } else if (metricName == "Cloud Cover") {
                    Text(String(value!) + " %")
                } else if (metricName == "UVIndex") {
                    Text(String(value!))
                }
            }
            Text(metricName)
        }
        .frame(width: 100, height: 150)
        .padding(10)
        .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.3))
        .cornerRadius(5)
        .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(Color.white, lineWidth: 1))
    }
}
