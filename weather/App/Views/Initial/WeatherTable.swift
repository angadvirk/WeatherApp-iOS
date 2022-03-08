//
//  WeatherTable.swift
//  weather
//
//  Created by Angad Singh Virk on 03/12/21.
//

import SwiftUI
import Alamofire

// Date Formatters
var isoDateFormatter = ISO8601DateFormatter() // To parse dates received from tomorrow.io
var dateFormatter = DateFormatter() // For dates
var dateFormatter_b = DateFormatter() // For sunrise & sunset times

struct WeatherTable: View {
    // Argument
    var intervals: [Interval]
    // Constant
    let intervalsPerScreen: Int = 7
    // Body
    var body: some View {
        TabView {
            ScrollView {
                Divider()
                ForEach(0..<intervalsPerScreen) { index in
                    HStack(spacing: 0) {
                        Text(isoDateFormatter.date(from: intervals[index].startTime)!, formatter: dateFormatter)
                            .padding(.horizontal, 0)
                            .frame(width: 90, height: 20)
                            .offset(x: -10)
                        Image(codeToStatus[intervals[index].values!.weatherCode!]!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                        Text(isoDateFormatter.date(from: intervals[index].values!.sunriseTime!)!, formatter: dateFormatter_b)
                            .frame(width: 60, height: 20)
                        Image("sun-rise")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                        Text(isoDateFormatter.date(from: intervals[index].values!.sunsetTime!)!, formatter: dateFormatter_b)
                            .frame(width: 60, height: 20)
                        Image("sun-set")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    }.padding(.horizontal, 0)
                    Divider()
                }
                .padding(.horizontal, 0)
            }
            .frame(width: 340, height: 290)
            .listStyle(InsetListStyle())
            .cornerRadius(5)
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.5))
            .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color.white, lineWidth: 1))
            .padding(.bottom, 60)
            .padding(.horizontal, 0)
            ScrollView {
                Divider()
                ForEach(intervalsPerScreen..<2*intervalsPerScreen) { index in
                    HStack(spacing: 0) {
                        Text(isoDateFormatter.date(from: intervals[index].startTime)!, formatter: dateFormatter)
                            .padding(.horizontal, 0)
                            .frame(width: 90, height: 20)
                            .offset(x: -10)
                        Image(codeToStatus[intervals[index].values!.weatherCode!]!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                        Text(isoDateFormatter.date(from: intervals[index].values!.sunriseTime!)!, formatter: dateFormatter_b)
                            .frame(width: 60, height: 20)
                        Image("sun-rise")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                        Text(isoDateFormatter.date(from: intervals[index].values!.sunsetTime!)!, formatter: dateFormatter_b)
                            .frame(width: 60, height: 20)
                        Image("sun-set")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    }.padding(.horizontal, 0)
                    Divider()
                }
                .padding(.horizontal, 0)
            }
            .frame(width: 340, height: 290)
            .listStyle(InsetListStyle())
            .cornerRadius(5)
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.5))
            .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color.white, lineWidth: 1))
            .padding(.bottom, 60)
            .padding(.horizontal, 0)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 355)
        .cornerRadius(5)
        .onAppear {
            // For dates
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "MM/dd/yyyy"
            // For sunrise & sunset times
            dateFormatter_b.dateStyle = .none
            dateFormatter_b.timeStyle = .short
            dateFormatter_b.dateFormat = "HH:mm"
        }
    }
}
