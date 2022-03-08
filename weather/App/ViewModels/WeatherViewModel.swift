//
//  InitialViewModel.swift
//  weather
//
//  Created by Angad Singh Virk on 05/12/21.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    // Properties
    @Published var weatherData: WeatherData?
    static let shared_initial = WeatherViewModel() // For initial view
    static let shared_results = WeatherViewModel() // For results views
        
    init() {}
    
    func fetchWeatherData(lat: Double, lng: Double) {
        let endpoint = "/weather" + "?lat=" + String(lat) + "&lng=" + String(lng)
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
                    self.weatherData = try decoder.decode(WeatherData.self, from: data!)
                    //print("DEBUG: Weather Data:")
                    //print(self.weatherData!.data!.timelines![1].intervals![0].values!.temperature!)
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
