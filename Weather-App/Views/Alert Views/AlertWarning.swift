//
//  WeatherAlert.swift
//  Weather-App
//
//  Created by Matt Sullivan on 31/08/2023.
//

import SwiftUI

struct AlertWarning: View {
    @StateObject var weatherDataHelper = WeatherData.shared
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if let weatherAlert = weatherDataHelper.weatherAlerts?.first {
            VStack(alignment: .leading) {
                Text("SEVERE WEATHER")
                    .modifier(CalloutTextStyle())
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.yellow)
                        Text("\(weatherAlert.severity.description.capitalizedSentence) Weather Warning")
                            .fontWeight(.bold)
                    }
                    Spacer()
                    Text("\(weatherAlert.summary) until \(weatherAlert.metadata.expirationDate.formatted(date: .abbreviated, time: .shortened))")
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Text(weatherAlert.source)
                            .padding(.trailing, 0)
                        Text("-")
                        Link(destination: weatherAlert.detailsURL, label : {
                            Text("Info")
                                .padding(.leading, 0)
                                .underline()
                        })
                    }
                    .font(.caption)
                    .foregroundStyle(Color(.darkTransparent))
                    
                }
                .modifier(GlassCard())
            }
            if sizeClass == .compact {
                Spacer(minLength: 20)
            }
        }
    }
}

#Preview {
    AlertWarning()
}
