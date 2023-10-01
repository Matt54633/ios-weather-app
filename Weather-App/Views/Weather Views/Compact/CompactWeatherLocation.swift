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
                    if sizeClass == .compact {
                        RainGraph()
                        Spacer(minLength: 20)
                        HourList()
                        Spacer(minLength: 20)
                        DayList()
                        Spacer(minLength: 20)
                        MapView(isUserLocation: locationName.isEmpty, locationName: locationName)
                    } else {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                VStack {
                                    HourList()
                                    Spacer(minLength: 20)
                                    MapView(isUserLocation: locationName.isEmpty, locationName: locationName)
                                        .frame(height: 430)
                                }
                                Spacer(minLength: 20)
                                DayList()
                            }
                        }
                    }
//                    Spacer(minLength: 20)
//                    WeatherInsights()
                    Spacer(minLength: 50)
                    WeatherAttribution()
                }
                .padding(sizeClass == .compact ? .init(.init(top: 15, leading: 15, bottom: 15, trailing: 15)) : .init(top: 40, leading: 40, bottom: 40, trailing: 40))
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
    let locationName: String

    var body: some View {
        if isUserLocation {
            UserLocationMap()
        } else {
            AddedLocationMap(locationName: locationName)
        }
    }
}

struct WeatherLocation_Previews: PreviewProvider {
    static var previews: some View {
        WeatherLocation(locationName: "", fullLocationName: "")
    }
}
