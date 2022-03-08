//
//  GeocodingViewModel.swift
//  weather
//
//  Created by Angad Singh Virk on 05/12/21.
//

import Foundation
import SwiftUI

@MainActor
class GeocodingViewModel: ObservableObject {
    // Properties
    @Published var geocodingData: GeocodingData?
    static let shared_results = GeocodingViewModel()
    
    init() {}
    
    func fetchGeocodingData(city: String, state: String, weatherViewModel: WeatherViewModel) {
        var addressString = "?address="
        addressString += city.replacingOccurrences(of: " ", with: "%20")
        addressString += state.replacingOccurrences(of: " ", with: "%20")
        let endpoint = "/geocoding" + "?address=" + addressString
        let url = URL(string: ApiConstants.baseUrl + endpoint)
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            // Check for errors
            if error == nil && data != nil {
                // Parse JSON
                let decoder = JSONDecoder()
                do {
                    self.geocodingData = try decoder.decode(GeocodingData.self, from: data!)
                    if (self.geocodingData != nil) {
                        if (self.geocodingData!.status == "OK") {
                            // Get weather data from lat/lng
                            print(self.geocodingData!.results!.first!.geometry!.location!.lat!)
                            weatherViewModel.fetchWeatherData(
                                lat: self.geocodingData!.results!.first!.geometry!.location!.lat!,
                                lng: self.geocodingData!.results!.first!.geometry!.location!.lng!)
                        }
                    }
                }
                catch DecodingError.dataCorrupted(let context)
                {
                    print(context.debugDescription)
                }
                catch DecodingError.keyNotFound(let key, let context)
                {
                    print("\(key.stringValue) was not found,\(context.debugDescription)")
                }
                catch DecodingError.typeMismatch(let type, let context)
                {
                    print("\(type) was expected, \(context.debugDescription)")
                }
                catch DecodingError.valueNotFound(let type, let context)
                {
                    print("no value was found for \(type),\(context.debugDescription)")
                }
                catch let error
                {
                    print(error)
                }
            }
        }
        // Make the API Call
        dataTask.resume()
    }
}
