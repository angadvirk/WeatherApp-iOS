//
//  MainView.swift
//  weather
//
//  Created by Angad Singh Virk on 08/12/21.
//

import SwiftUI
import SwiftSpinner

struct MainView: View {
    // Variables
    @ObservedObject var locationManager = LocationManager.sharedLocationManager
    @ObservedObject var wvm_i = WeatherViewModel.shared_initial
    @ObservedObject var rgvm = ReverseGeocodingViewModel.shared
    @ObservedObject var favoritesViewModel = FavoritesViewModel.shared
    @ObservedObject var toastViewModel = ToastViewModel.shared
    @State var searchStr: String = ""
    // Body
    var body: some View {
        if locationManager.userLocation == nil {
            MessageView(message: "Getting your location... Please wait a moment.")
            .onAppear {
                LocationManager.sharedLocationManager.requestLocation()
            }
        }
        else if (wvm_i.weatherData?.code ?? 0 >= 400000) {
            MessageView(message: "Sorry, an error occurred while trying to fetch weather details. Please try again later.")
            .onAppear {
                SwiftSpinner.hide()
            }
        }
        else {
            NavigationView {
                ZStack {
                    Image("background").resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all)
                    if (wvm_i.weatherData != nil && !(wvm_i.weatherData?.code ?? 0 >= 400000)) {
                        VStack {
                            SearchBar(searchVal: searchStr)
                            Spacer()
                            TabView {
                                InitialView()
                                ForEach(favoritesViewModel.favorites ?? [], id: \.self) {
                                    FavoritesView(
                                        cityName: $0.components(separatedBy: ", ").first!,
                                        stateName: $0.components(separatedBy: ", ").last!
                                    )
                                }
                            }.tabViewStyle(.page(indexDisplayMode: .always))
                            .overlay {
                                if (toastViewModel.toastCity != nil && toastViewModel.toastCity != "")
                                {
                                    if (toastViewModel.showToast_a) // put in the viewModel as well?
                                    {
                                        ToastIntegratedController(cityName: toastViewModel.toastCity!, removed: true)
                                        .frame(width: 280, height: 50)
                                        .offset(y:300)
                                    }
                                    else {
                                        ToastIntegratedController(cityName: toastViewModel.toastCity!, removed: true)
                                        .frame(width: 280, height: 50)
                                        .offset(y:300)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarHidden(true)
                .onAppear {
                    if (wvm_i.weatherData == nil) {
                        // Fetch weather data
                        SwiftSpinner.show("Fetching Weather Details for Current Location...")
                        wvm_i.fetchWeatherData(
                            lat: LocationManager.sharedLocationManager.userLocation!.coordinate.latitude,
                            lng: LocationManager.sharedLocationManager.userLocation!.coordinate.longitude
                        )
                        // Perform reverse geocoding to get City Name from lat, lng
                        rgvm.fetchReverseGeocodingData(
                            lat: LocationManager.sharedLocationManager.userLocation!.coordinate.latitude,
                            lng: LocationManager.sharedLocationManager.userLocation!.coordinate.longitude
                        )
                    }
                }
            }
        }
    }
}
