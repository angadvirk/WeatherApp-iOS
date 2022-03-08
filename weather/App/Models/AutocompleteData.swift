//
//  AutocompleteData.swift
//  weather
//
//  Created by Angad Singh Virk on 07/12/21.
//

import Foundation

struct AutocompleteData: Codable {
    var predictions: [Prediction]?
    var status: String? = ""
}

struct Prediction: Codable {
    var terms: [Term]?
}

struct Term: Codable {
    var value: String? = ""
}
