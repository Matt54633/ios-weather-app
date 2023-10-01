//
//  WeatherLocation.swift
//  Weather-App
//
//  Created by Matt Sullivan on 03/08/2023.
//

import SwiftUI
import WidgetKit
import CoreLocation
import MapKit

struct CompactWeatherLocation: View {
    @StateObject var userLocationHelper = LocationManager.shared
    @StateObject var weatherDataHelper = WeatherData.shared
    
    let locationName: String
    let fullLocationName: String
    
    var body: some View {
        ZStack {
            Background()
            ScrollView {
                VStack {
                    WeatherOverview(searchedLocationName: locationName)
                    Spacer(minLength: 50)
                    AlertWarning()
                    RainGraph()
                    CompactHourList()
                    Spacer(minLength: 20)
                    CompactDayList()
                    Spacer(minLength: 20)
                    MapView(isUserLocation: locationName.isEmpty, locationName: locationName)
                    //                    Spacer(minLength: 20)
                    //                    WeatherInsights()
                    Spacer(minLength: 50)
                    WeatherAttribution()
                }
                .padding(.init(top: 15, leading: 15, bottom: 15, trailing: 15))
                .redacted(reason: weatherDataHelper.isLoading == true ? .placeholder : [])
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .foregroundStyle(.white)
        .onAppear(perform: loadLocationData)
        .refreshable {
            loadLocationData()
        }
    }
    
    private func loadLocationData() {
        if locationName.isEmpty {
            userLocationHelper.loadUserCurrentLocation()
            weatherDataHelper.loadCurrentWeatherData()
        } else {
            Task.detached { @MainActor in
                await userLocationHelper.loadAddedLocation(fullLocationName: fullLocationName)
            }
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
}

struct WeatherLocation_Previews: PreviewProvider {
    static var previews: some View {
        CompactWeatherLocation(locationName: "", fullLocationName: "")
    }
}
