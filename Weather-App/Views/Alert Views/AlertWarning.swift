//
//  WeatherAlert.swift
//  Weather-App
//
//  Created by Matt Sullivan on 31/08/2023.
//

import SwiftUI

struct Alert: View {
    @StateObject var weatherDataHelper = WeatherData.shared
    
    var body: some View {
        if let weatherAlert = weatherDataHelper.weatherAlerts?.first {
            VStack(alignment: .leading) {
                Text(weatherAlert.severity.description)
                Text(weatherAlert.source)
                Text(weatherAlert.summary)
                if let region = weatherAlert.region {
                    Text(region.capitalized(with: .current))
                }
                Link("Provider", destination: weatherAlert.detailsURL)
            }
            .modifier(GlassCard())
        }
    }
}

#Preview {
    WeatherAlert()
}
