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
    
    // search location information
    let locationName: String
    let fullLocationName: String
    
    var body: some View {
        ZStack {
            Background()
            ScrollView {
                VStack {
                    if locationName == "" {
                        WeatherOverview()
                    } else {
                        WeatherOverview(searchedLocationName: locationName)
                    }
                    Spacer(minLength: 50)
                    if sizeClass == .compact {
                        RainGraph()
                        Spacer(minLength: 20)
                        HourList()
                        Spacer(minLength: 20)
                        DayList()
                        Spacer(minLength: 20)
                        if locationName == "" {
                            UserLocationMap()
                        } else {
                            AddedLocationMap()
                        }
                    } else {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                VStack {
                                    HourList()
                                    Spacer(minLength: 20)
                                    if locationName == "" {
                                        UserLocationMap()
                                            .frame(height: 310)
                                    } else {
                                        AddedLocationMap()
                                    }
                                }
                                Spacer(minLength: 20)
                                DayList()
                            }
                        }
                    }
                    Spacer(minLength: 20)
                    WeatherInsights()
                    Spacer(minLength: 20)
                    WeatherAttribution()
                }
                .padding()
                .redacted(reason: weatherDataHelper.isLoading == true ? .placeholder : [])
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .fontDesign(.rounded)
        .foregroundStyle(.white)
        .onAppear {
            userLocationHelper.loadUserCurrentLocation()
            weatherDataHelper.loadCurrentWeatherData()
            Task.detached { @MainActor in
                await userLocationHelper.loadAddedLocation(fullLocationName: fullLocationName)
            }
            WidgetCenter.shared.reloadAllTimelines()
        }
        .refreshable {
            userLocationHelper.loadUserCurrentLocation()
            weatherDataHelper.loadCurrentWeatherData()
            await userLocationHelper.loadAddedLocation(fullLocationName: fullLocationName)
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}

struct WeatherLocation_Previews: PreviewProvider {
    static var previews: some View {
        WeatherLocation(locationName: "", fullLocationName: "")
    }
}
