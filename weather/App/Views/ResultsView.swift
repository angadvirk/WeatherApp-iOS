//
//  ResultsView.swift
//  weather
//
//  Created by Angad Singh Virk on 07/12/21.
//

import SwiftUI
import SwiftSpinner
import Toast

struct ResultsView: View {
    // Arguments
    var searchCity: String
    var searchState: String
    // Variables
    @ObservedObject var geocodingViewModel = GeocodingViewModel.shared_results
    @ObservedObject var weatherViewModel = WeatherViewModel.shared_results
    @ObservedObject var favoritesViewModel = FavoritesViewModel.shared
    @State var showAddedToast: Bool = false
    @State var showRemovedToast: Bool = false
    @Environment(\.presentationMode) var presentationMode // for custom back button
    // Body
    var body: some View {
        // Make background appear when view is loading + redo custom back button method...
        ZStack {
            if (weatherViewModel.weatherData == nil) {
                Image("background").resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all)
            }
            // Show error view if there is an api error
            else if (weatherViewModel.weatherData!.code ?? 0 >= 400000) {
                MessageView(message: "Sorry, an error occurred while trying to fetch weather details. Please try again later.").onAppear { SwiftSpinner.hide() }
            }
            else {
                VStack {
                    HStack {
                        Spacer()
                        if (!favoritesViewModel.favorites!.contains("\(searchCity), \(searchState)")) {
                            // Show 'Add Favorite' Button
                            Button {
                                self.showAddedToast = true
                                self.showRemovedToast = false
                                // Add "\(searchCity), \(searchState)" to favorites list + User Defaults
                                favoritesViewModel.favorites!.append("\(searchCity), \(searchState)")
                                UserDefaults.standard.set(favoritesViewModel.favorites!, forKey: "favorites")
                            } label: {
                                Image("Favorite_add")
                            }.padding(.trailing, 48)
                        }
                        else {
                            // Show 'Remove Favorite' Button
                            Button {
                                self.showRemovedToast = true
                                self.showAddedToast = false
                                // Remove City/State Pair from User Defaults
                                favoritesViewModel.favorites!.remove(at: favoritesViewModel.favorites!.firstIndex(of: "\(searchCity), \(searchState)")!)
                                UserDefaults.standard.set(favoritesViewModel.favorites!, forKey: "favorites")
                            } label: {
                                Image("Favorite_remove")
                            }.padding(.trailing, 48)
                        }
                    }
                    NavigationLink(destination: DetailsView(
                        windSpeed: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.windSpeed!,
                        pressure: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.pressureSeaLevel!,
                        precipitation: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.precipitationProbability!,
                        temperature: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.temperature!,
                        weatherCode: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.weatherCode!,
                        humidity: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.humidity!,
                        visibility: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.visibility!,
                        cloudCover: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.cloudCover!,
                        uvIndex: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.uvIndex!,
                        cityName: searchCity,
                        intervals: weatherViewModel.weatherData!.data!.timelines![1].intervals!
                        )
                    ) {
                        StatusCard(
                            temperature: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.temperature!,
                            weatherCode: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.weatherCode!,
                            cityName: searchCity
                        )
                        .foregroundColor(.black)
                    }
                    PropPreview(
                        humidity: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.humidity!,
                        windSpeed: weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.windSpeed!,
                        visibility:  weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.visibility!,
                        pressure:  weatherViewModel.weatherData!.data!.timelines![1].intervals![0].values!.pressureSeaLevel!
                    ).padding(.vertical, 24)
                    WeatherTable(intervals: weatherViewModel.weatherData!.data!.timelines![1].intervals!)
                    .overlay { // Makes a tiny part of the table at the bottom unclickable, but it's a very minor UX issue.
                        if (self.showAddedToast) {
                            ToastIntegratedController(cityName: searchCity, removed: false)
                                .frame(width: 280, height: 50)
                                .offset(y:85)
                        }
                        else if (self.showRemovedToast) {
                            ToastIntegratedController(cityName: searchCity, removed: true)
                                .frame(width: 280, height: 50)
                                .offset(y:85)
                        }
                    }
                }
                .onAppear {
                    SwiftSpinner.hide()
                }
            }
        }
        .background(Image("background").resizable()
                        .frame(width: 500, height: 810)
                        .offset(y: 20))
        .navigationTitle(searchCity)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: // Custom back button
                Button(action: {
                    // Set state variables to false
                    self.showAddedToast = false
                    self.showRemovedToast = false
                    // Set results view model data to nil
                    if (weatherViewModel.weatherData != nil ||
                        geocodingViewModel.geocodingData != nil)
                    {
                        weatherViewModel.weatherData = nil
                        geocodingViewModel.geocodingData = nil
                    }
                    // Go back to previous view
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                    Text("Search")
                }),
            trailing:
                TwitterButton(
                    cityName: searchCity,
                    intervals: weatherViewModel.weatherData?.data?.timelines?[1].intervals ?? [],
                    temperature: weatherViewModel.weatherData?.data?.timelines?[1].intervals?[0].values?.temperature ?? .infinity,
                    weatherCode: weatherViewModel.weatherData?.data?.timelines?[1].intervals?[0].values?.weatherCode ?? -1
                )
        )
        .onAppear {
            if (geocodingViewModel.geocodingData == nil && weatherViewModel.weatherData == nil) {
                // Call 'fetchGeocodingData', which in turn fetches weather data as well
                SwiftSpinner.show("Fetching Weather Details for " + searchCity + "...")
                geocodingViewModel.fetchGeocodingData(
                    city: searchCity,
                    state: searchState,
                    weatherViewModel: weatherViewModel)
            }
        }
    }
}
