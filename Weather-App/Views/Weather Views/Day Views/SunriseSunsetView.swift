//
//  SunriseSunsetView.swift
//  Weather-App
//
//  Created by Matt Sullivan on 31/08/2023.
//

import SwiftUI

struct SunriseSunsetView: View {
    let sunrise: Date?
    let sunset: Date?
    
    var body: some View {
        HStack {
            Group {
                HStack {
                    Image(systemName: "sunrise.fill")
                    Text(sunrise?.formatted(date: .omitted, time: .shortened) ?? "")
                }
                .help("Sunrise")
                HStack {
                    Image(systemName: "sunset.fill")
                    Text(sunset?.formatted(date: .omitted, time: .shortened) ?? "")
                }
                .help("Sunset")
            }
            .padding(10)
            .background(Color("Transparent"))
            .clipShape(RoundedRectangle(cornerRadius:20))
            .shadow(radius: 5)
        }
    }
}
