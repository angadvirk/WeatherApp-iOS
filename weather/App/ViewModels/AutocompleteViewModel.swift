//
//  AutocompleteViewModel.swift
//  weather
//
//  Created by Angad Singh Virk on 07/12/21.
//

import Foundation

@MainActor
class AutocompleteViewModel: ObservableObject {
    // Properties
    @Published var autocompleteData: AutocompleteData?
    static let shared = AutocompleteViewModel()
    
    init() {}
    
    func fetchAutocompleteData(input: String) {
        let endpoint = "/autocomplete" + "?input=" + input
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
                    self.autocompleteData = try decoder.decode(AutocompleteData.self, from: data!)
                    if (self.autocompleteData != nil) {
                        if (self.autocompleteData!.status == "OK") {
                            print(self.autocompleteData!.predictions!.first!.terms!.first!.value!)
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
