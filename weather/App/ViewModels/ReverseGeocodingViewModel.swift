//
//  ReverseGeocodingViewModel.swift
//  weather
//
//  Created by Angad Singh Virk on 08/12/21.
//

import Foundation
import SwiftUI

@MainActor
class ReverseGeocodingViewModel: ObservableObject {
    // Properties
    @Published var reverseGeocodingData: ReverseGeocodingData?
    static let shared = ReverseGeocodingViewModel()
    
    init() {}
    
    func fetchReverseGeocodingData(lat: Double, lng: Double) {
        let endpoint = "/rev-geocoding" + "?latlng=" + String(lat) + "," + String(lng)
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
                    self.reverseGeocodingData = try decoder.decode(ReverseGeocodingData.self, from: data!)
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
