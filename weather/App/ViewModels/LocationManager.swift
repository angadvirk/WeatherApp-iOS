//
//  LocationManager.swift
//  weather
//
//  Created by Angad Singh Virk on 06/12/21.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    // Properties
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    static let sharedLocationManager = LocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status
        {
        case .notDetermined:
            print("DEBUG locationManager: not determined")
        case .restricted:
            print("DEBUG locationManager: restricted")
            // Set default location in case location services was denied
            self.userLocation = CLLocation(latitude: 34.02235, longitude: -118.285118)
        case .denied:
            print("DEBUG locationManager: denied")
            // Set default location in case location services was denied
            self.userLocation = CLLocation(latitude: 34.02235, longitude: -118.285118)
        case .authorizedAlways:
            print("DEBUG locationManager: authorizedAlways")
        case .authorizedWhenInUse:
            print("DEBUG locationManager: authorizedWhenInUse")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.userLocation = location
    }
}
