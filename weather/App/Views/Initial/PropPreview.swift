//
//  PropPreview.swift
//  weather
//
//  Created by Angad Singh Virk on 03/12/21.
//

import SwiftUI

struct PropPreview: View {
    // Arguments
    var humidity: Double
    var windSpeed: Double
    var visibility: Double
    var pressure: Double
    // Body
    var body: some View {
        HStack {
            VStack {
                Text("Humidity")
                Image("Humidity")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                Text(String(humidity) + " %")
            }
            VStack {
                Text("Wind Speed")
                Image("WindSpeed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                Text(String(windSpeed) + " mph")
            }
            VStack {
                Text("Visibility")
                Image("Visibility")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                Text(String(visibility) + " mi")
            }
            VStack {
                Text("Pressure")
                Image("Pressure")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                Text(String(pressure) + " inHg")
            }
        }
    }
}
