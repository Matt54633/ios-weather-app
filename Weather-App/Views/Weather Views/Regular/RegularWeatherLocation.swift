//
//  RegularWeatherLocation.swift
//  Weather-App
//
//  Created by Matt Sullivan on 31/08/2023.
//

import SwiftUI

import SwiftUI
import WidgetKit
import CoreLocation
import MapKit

struct RegularWeatherLocation: View {
    @StateObject var userLocationHelper = LocationManager.shared
    @StateObject var weatherDataHelper = WeatherData.shared
    
    let locationName: String
    let fullLocationName: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                ScrollView {
                    VStack {
                        WeatherOverview(searchedLocationName: locationName)
                        Spacer(minLength: 50)
                        VStack(alignment: .leading) {
                            VStack {
                                AlertWarning()
                                Spacer(minLength: 20)
                                RainGraph()
                            }
                            Spacer(minLength: 20)
                            HStack(alignment: .top) {
                                VStack {
                                    RegularHourList()
                                    Spacer(minLength: 20)
                                    MapView(isUserLocation: locationName.isEmpty, locationName: locationName)
                                        .frame(height: 430)
                                }
                                Spacer(minLength: 20)
                                RegularDayList()
                            }
                        }
                        //                    Spacer(minLength: 20)
                        //                    WeatherInsights()
                        Spacer(minLength: 50)
                        WeatherAttribution()
                    }
                    .padding(.init(top: 0, leading: 60, bottom: 20, trailing: 60))
                    .redacted(reason: weatherDataHelper.isLoading == true ? .placeholder : [])
                }
            }
            .task {
                loadLocationData()                    
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .foregroundStyle(.white)
            .onAppear {
                loadLocationData()
            }
            .onChange(of: locationName) {
                loadLocationData()
            }
            .refreshable {
                loadLocationData()
            }
        }
    }
    
    func loadLocationData() {
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

#Preview {
    RegularWeatherLocation(locationName: "", fullLocationName: "")
}
