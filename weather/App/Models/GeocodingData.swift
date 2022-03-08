//
//  GeocodingData.swift
//  weather
//
//  Created by Angad Singh Virk on 07/12/21.
//

import Foundation

struct GeocodingData: Codable {
    var results: [GeocodingResult]?
    var status: String? = ""
}

struct GeocodingResult: Codable {
    var geometry: GeocodingGeometry?
}

struct GeocodingGeometry: Codable {
    var location: GeocodingLocation?
}

struct GeocodingLocation: Codable {
    var lat: Double? = 0
    var lng: Double? = 0
}
