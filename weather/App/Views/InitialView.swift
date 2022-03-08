//
//  InitialView.swift
//  weather
//
//  Created by Angad Singh Virk on 03/12/21.
//

import SwiftUI
import SwiftSpinner

struct InitialView: View {
    // Variables
    @ObservedObject var wvm = WeatherViewModel.shared_initial
    @ObservedObject var rgvm = ReverseGeocodingViewModel.shared
    // Body
    var body: some View {
        VStack {
            NavigationLink(destination: DetailsView(
                windSpeed: wvm.weatherData!.data!.timelines![1].intervals![0].values!.windSpeed!,
                pressure: wvm.weatherData!.data!.timelines![1].intervals![0].values!.pressureSeaLevel!,
                precipitation: wvm.weatherData!.data!.timelines![1].intervals![0].values!.precipitationProbability!,
                temperature: wvm.weatherData!.data!.timelines![1].intervals![0].values!.temperature!,
                weatherCode: wvm.weatherData!.data!.timelines![1].intervals![0].values!.weatherCode!,
                humidity: wvm.weatherData!.data!.timelines![1].intervals![0].values!.humidity!,
                visibility: wvm.weatherData!.data!.timelines![1].intervals![0].values!.visibility!,
                cloudCover: wvm.weatherData!.data!.timelines![1].intervals![0].values!.cloudCover!,
                uvIndex: wvm.weatherData!.data!.timelines![1].intervals![0].values!.uvIndex!,
                cityName: rgvm.reverseGeocodingData?.results?.first?.formatted_address?.components(separatedBy: ", ").first ?? "",
                intervals: wvm.weatherData!.data!.timelines![1].intervals!
                
            )) {
                StatusCard(
                    temperature: wvm.weatherData!.data!.timelines![1].intervals![0].values!.temperature!,
                    weatherCode: wvm.weatherData!.data!.timelines![1].intervals![0].values!.weatherCode!,
                    cityName: rgvm.reverseGeocodingData?.results?.first?.formatted_address?.components(separatedBy: ", ").first ?? ""
                ).padding(.top, 48)
                .foregroundColor(.black)
            }
            Spacer()
            PropPreview(
                humidity: wvm.weatherData!.data!.timelines![1].intervals![0].values!.humidity!,
                windSpeed: wvm.weatherData!.data!.timelines![1].intervals![0].values!.windSpeed!,
                visibility:  wvm.weatherData!.data!.timelines![1].intervals![0].values!.visibility!,
                pressure:  wvm.weatherData!.data!.timelines![1].intervals![0].values!.pressureSeaLevel!
            ).padding(.vertical, 24)
            Spacer()
            WeatherTable(intervals: wvm.weatherData!.data!.timelines![1].intervals!)
        }
        .onAppear {
            SwiftSpinner.hide()
        }
    }
}
