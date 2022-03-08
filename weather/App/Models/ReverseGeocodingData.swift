//
//  ReverseGeocodingData.swift
//  weather
//
//  Created by Angad Singh Virk on 08/12/21.
//

import Foundation

struct ReverseGeocodingData: Codable {
    var status: String? = ""
    var results: [Result]?
}

struct Result: Codable {
    var formatted_address: String? = ""
}
