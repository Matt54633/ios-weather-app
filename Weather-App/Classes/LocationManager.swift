//
//  LocationManager.swift
//  Weather-App
//
//  Created by Matt Sullivan on 03/08/2023.
//

import SwiftUI
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var userLocation: CLLocation?
    var region = MKCoordinateRegion()
    @Published var locationPermission: Bool?
    @Published var placemark: CLPlacemark?
    @Published var searchedPlacemark: CLPlacemark?
    @Published var searchLocation: CLLocation?
    @Published var searchMapPosition: MapCameraPosition?
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    static let shared = LocationManager(accuracy: kCLLocationAccuracyHundredMeters)
    
    init(accuracy: CLLocationAccuracy) {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = accuracy
    }
    
    func requestPermission() {
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
        
        self.region =
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            } else {
                self.placemark = nil
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways ||
            manager.authorizationStatus == .authorizedWhenInUse {
            self.locationManager.requestLocation()
            self.locationPermission = true
        } else {
            self.locationPermission = false
        }
    }
    
    func geocodeLocation(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
            if error == nil {
                self.searchedPlacemark = places?[0]
            } else {
                self.searchedPlacemark = nil
            }
        })
    }
    
    func loadUserCurrentLocation() {
        requestPermission()
        locationManager.requestLocation()
    }
    
    func loadAddedLocation(fullLocationName: String) async {
        let geoCoder = CLGeocoder()
        
        await withTaskGroup(of: Void.self) { taskGroup in
            taskGroup.addTask {
                await withCheckedContinuation { continuation in
                    geoCoder.geocodeAddressString(fullLocationName) { (placemarks, error) in
                        guard
                            let placemarks = placemarks,
                            let location = placemarks.first?.location
                        else {
                            continuation.resume(returning: ())
                            return
                        }
                        
                        self.searchLocation = location
                        
                        if let searchLoc = self.searchLocation {
                            self.searchMapPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: searchLoc.coordinate.latitude, longitude: searchLoc.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
                        }
                        continuation.resume(returning: ())
                    }
                }
            }
            for await _ in taskGroup {}
            await WeatherData.shared.loadSearchLocationData()
        }
    }
}
