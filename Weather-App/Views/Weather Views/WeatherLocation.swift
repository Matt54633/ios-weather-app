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

struct WeatherLocation: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @ObservedObject var userLocationHelper = LocationManager.shared
    @ObservedObject var weatherDataHelper = WeatherData.shared
    
    let locationName: String
    let fullLocationName: String
    
    var body: some View {
        ZStack {
            Background()
            ScrollView {
                VStack {
                    WeatherOverview(searchedLocationName: locationName)
                    Spacer(minLength: 50)
                    if sizeClass == .compact {
                        RainGraph()
                        Spacer(minLength: 20)
                        HourList()
                        Spacer(minLength: 20)
                        DayList()
                        Spacer(minLength: 20)
                        MapView(isUserLocation: locationName.isEmpty)
                    } else {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                VStack {
                                    HourList()
                                    Spacer(minLength: 20)
                                    MapView(isUserLocation: locationName.isEmpty)
                                        .frame(height: 310)
                                }
                                Spacer(minLength: 20)
                                DayList()
                            }
                        }
                    }
                    Spacer(minLength: 20)
                    WeatherInsights()
                    Spacer(minLength: 50)
                    WeatherAttribution()
                }
                .padding()
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

struct MapView: View {
    let isUserLocation: Bool
    
    var body: some View {
        if isUserLocation {
            UserLocationMap()
        } else {
            AddedLocationMap()
        }
    }
}

struct WeatherLocation_Previews: PreviewProvider {
    static var previews: some View {
        WeatherLocation(locationName: "", fullLocationName: "")
    }
}
