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
    @ObservedObject var weatherDataHelper = WeatherData.shared
    @ObservedObject var userLocationHelper = LocationManager.shared
    var searchedLocationName: String?
    
    var body: some View {
        VStack {
            if let currentWeather = weatherDataHelper.currentWeather {
                HStack(alignment: .center) {
                    if let searchLocName = searchedLocationName {
                        Text(searchLocName)
                            .multilineTextAlignment(.center)
                    }
                    else {
                        if let placemark = userLocationHelper.placemark?.locality {
                            Text(placemark)
                                .multilineTextAlignment(.center)
                        }
                    }
                    Image(systemName: currentWeather.symbolName)
                        .modifier(SymbolFill())
                }
                .fontWeight(.regular)
                .font(.title)
                Spacer(minLength: 10)
                Text("\(currentWeather.temperature.value.rounded(.toNearestOrEven).formatted())°")
                    .font(.system(size: 64))
                    .fontWeight(.semibold)
                Spacer(minLength: 10)
                VStack {
                    Text(currentWeather.condition.description)
                    if let dailyWeather = weatherDataHelper.dailyForecast {
                        Text("H:\(dailyWeather[0].highTemperature.value.rounded(.toNearestOrEven).formatted())° | Low:\(dailyWeather[0].lowTemperature.value.rounded(.toNearestOrEven).formatted())°")
                    }
                }
                .font(.headline)
                .fontWeight(.regular)
            }
        }
    }
}

struct WeatherOverview_Previews: PreviewProvider {
    static var previews: some View {
        WeatherOverview()
    }
}
