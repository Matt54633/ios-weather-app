//
//  WeatherDetailCapsules.swift
//  Weather-App
//
//  Created by Matt Sullivan on 30/08/2023.
//

import SwiftUI

struct WeatherDetailCapsules: View {
    @StateObject var weatherDataHelper = WeatherData.shared
    
    var body: some View {
        if let currentWeather = weatherDataHelper.currentWeather, let dailyForecast = weatherDataHelper.dailyForecast {
            HStack() {
                
                HStack {
                    Image(systemName: "chevron.up")
                        .foregroundStyle(.yellow)
                        .fontWeight(.bold)
                        .font(.caption)
                    Text("\(dailyForecast[0].highTemperature.value.rounded(.toNearestOrEven).formatted())°")
                }
                .modifier(GlassCapsule())
                
                HStack {
                    Text(currentWeather.condition.description)
                }
                .modifier(GlassCapsule())

                HStack {
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.green)
                        .fontWeight(.bold)
                        .font(.caption)
                    Text("\(dailyForecast[0].lowTemperature.value.rounded(.toNearestOrEven).formatted())°")
                }
                .modifier(GlassCapsule())
                
            }
        }
    }
}

#Preview {
    WeatherDetailCapsules()
}
