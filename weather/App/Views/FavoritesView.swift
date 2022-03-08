//
//  FavoritesView.swift
//  weather
//
//  Created by Angad Singh Virk on 09/12/21.
//

import SwiftUI
import SwiftSpinner

struct FavoritesView: View {
    // Arguments
    var cityName: String
    var stateName: String
    // Variables
    @ObservedObject var wvm = WeatherViewModel()
    @ObservedObject var gvm = GeocodingViewModel()
    @ObservedObject var favoritesViewModel = FavoritesViewModel.shared
    @ObservedObject var toastViewModel = ToastViewModel.shared
    // Body
    var body: some View {
        VStack {
            if (wvm.weatherData == nil) {
                EmptyView()
            }
            else if (wvm.weatherData?.code ?? 0 >= 400000) {
                MessageView(message: "Sorry, an error occurred while trying to fetch weather details. Please try again later.")
                .onAppear {
                    SwiftSpinner.hide()
                }
            }
            else {
                HStack {
                    // Show 'Remove Favorite' Button
                    Spacer()
                    Button {
                        // Remove City/State Pair from User Defaults
                        if (favoritesViewModel.favorites != nil &&
                            favoritesViewModel.favorites != []) {
                            favoritesViewModel.favorites!.remove(
                                at: favoritesViewModel.favorites!.firstIndex(of: "\(cityName), \(stateName)")!)
                            UserDefaults.standard.set(favoritesViewModel.favorites!, forKey: "favorites")
                            toastViewModel.showToast(toastCity: cityName)
                        }
                    } label: {
                        Image("Favorite_remove")
                    }.padding(.trailing, 64)
                }.padding(.top, 40)
                NavigationLink(destination: DetailsView(
                    windSpeed: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.windSpeed ?? 0,
                    pressure: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.pressureSeaLevel ?? 0,
                    precipitation: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.precipitationProbability ?? 0,
                    temperature: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.temperature ?? 0,
                    weatherCode: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.weatherCode ?? 1000,
                    humidity: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.humidity ?? 0,
                    visibility: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.visibility ?? 0,
                    cloudCover: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.cloudCover ?? 0,
                    uvIndex: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.uvIndex ?? 0,
                    cityName: cityName,
                    intervals: wvm.weatherData?.data?.timelines?[1].intervals ?? []
                    
                )) {
                    StatusCard(
                        temperature: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.temperature ?? 0,
                        weatherCode: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.weatherCode ?? 1000,
                        cityName: cityName
                    )
                    .foregroundColor(.black)
                }
                Spacer()
                PropPreview(
                    humidity: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.humidity ?? 0,
                    windSpeed: wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.windSpeed ?? 0,
                    visibility:  wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.visibility ?? 0,
                    pressure:  wvm.weatherData?.data?.timelines?[1].intervals?[0].values?.pressureSeaLevel ?? 0
                ).padding(.vertical, 24)
                Spacer()
                WeatherTable(intervals: wvm.weatherData?.data?.timelines?[1].intervals ?? [])
            }
        }.onAppear {
            SwiftSpinner.show(duration: 1.6, title: "Fetching Weather Details...")
            if (wvm.weatherData == nil && gvm.geocodingData == nil) {
                // Perform geocoding + weather fetch
                gvm.fetchGeocodingData(city: cityName, state: stateName, weatherViewModel: wvm)
            }
        }
    }
}
