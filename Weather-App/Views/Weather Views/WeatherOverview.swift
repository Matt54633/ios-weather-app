//
//  WeatherOverview.swift
//  Weather-App
//
//  Created by Matt Sullivan on 03/08/2023.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct WeatherOverview: View {
    @StateObject var weatherDataHelper = WeatherData.shared
    @StateObject var userLocationHelper = LocationManager.shared
    var searchedLocationName: String?
    
    var body: some View {
        VStack {
            if let currentWeather = weatherDataHelper.currentWeather {
                HStack(alignment: .center) {
                    Text(searchedLocationName?.isEmpty == true ? (userLocationHelper.placemark?.locality ?? "") : searchedLocationName ?? "")
                        .multilineTextAlignment(.center)
                    Image(systemName: currentWeather.symbolName)
                        .modifier(SymbolFill())
                }
                .font(.title)
                      
                Spacer(minLength: 10)
                Text("\(currentWeather.temperature.value.rounded(.toNearestOrEven).formatted())°")
                    .font(.system(size: 68))
                    .fontWeight(.semibold)
                Spacer(minLength: 10)
                WeatherDetailCapsules()
            }
        }
        .fontWeight(.regular)
    }
}

struct WeatherOverview_Previews: PreviewProvider {
    static var previews: some View {
        WeatherOverview()
    }
}
