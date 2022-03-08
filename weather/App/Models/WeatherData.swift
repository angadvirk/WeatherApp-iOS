//
//  WeatherData.swift
//  weather
//
//  Created by Angad Singh Virk on 05/12/21.
//

import Foundation

struct WeatherData: Codable {
    var data: DataObj?
    var code: Int? = 0
}

struct DataObj: Codable {
    var timelines: [Timeline]?
}

struct Timeline: Codable {
    var intervals: [Interval]?
}

struct Interval: Codable, Equatable {
    static func == (lhs: Interval, rhs: Interval) -> Bool {
        return ((lhs.startTime == rhs.startTime) && (lhs.values == rhs.values))
    }
    
    var startTime: String = ""
    var values: ValuesObj?
}

struct ValuesObj: Codable, Equatable {
    var temperature: Double? = 0
    var weatherCode: Int? = 0
    var humidity: Double? = 0
    var windSpeed: Double? = 0
    var pressureSeaLevel: Double? = 0
    var visibility: Double? = 0
    var sunriseTime: String? = ""
    var sunsetTime: String? = ""
    // for DetailsView
    var precipitationProbability: Double? = 0
    var cloudCover: Double? = 0
    var uvIndex: Double? = 0
    // for Arearange Chart
    var temperatureMin: Double? = 0
    var temperatureMax: Double? = 0
    
    static func == (lhs: ValuesObj, rhs: ValuesObj) -> Bool {
        return ((lhs.temperature == rhs.temperature) &&
                (lhs.weatherCode == rhs.weatherCode) &&
                (lhs.humidity == rhs.humidity) &&
                (lhs.windSpeed == rhs.windSpeed) &&
                (lhs.pressureSeaLevel == rhs.pressureSeaLevel) &&
                (lhs.visibility == rhs.visibility) &&
                (lhs.sunriseTime == rhs.sunriseTime) &&
                (lhs.sunsetTime == rhs.sunsetTime) &&
                (lhs.precipitationProbability == rhs.precipitationProbability) &&
                (lhs.cloudCover == rhs.cloudCover) &&
                (lhs.uvIndex == rhs.uvIndex) &&
                (lhs.temperatureMin == rhs.temperatureMin) &&
                (lhs.temperatureMax == rhs.temperatureMax))
    }
}
