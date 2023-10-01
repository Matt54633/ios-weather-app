//
//  FeelsLikeGraph.swift
//  Weather-App
//
//  Created by Matt Sullivan on 12/08/2023.
//

import SwiftUI
import WeatherKit

struct FeelsLikeGraph: View {
    let hourData: Slice<Forecast<HourWeather>>.Element
    
    var body: some View {
        HStack {
            Image(systemName: "thermometer.medium")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.red, .white)
            Text("Feels Like")
            Spacer()
            Group {
                if hourData.apparentTemperature.value.rounded(.toNearestOrEven) > hourData.temperature.value.rounded(.toNearestOrEven) {
                    Image(systemName: "chevron.up")
                        .foregroundStyle(.yellow)
                        .fontWeight(.bold)
                } else if hourData.apparentTemperature.value.rounded(.toNearestOrEven) < hourData.temperature.value.rounded(.toNearestOrEven)  {
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.green)
                        .fontWeight(.bold)
                } else {
                    Image(systemName: "equal")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
            }
            Text("\(hourData.apparentTemperature.value.rounded(.toNearestOrEven).formatted())°")
                .font(.title)
                .fontWeight(.semibold)
        }
        .modifier(GlassCard())
    }
}

//#Preview {
//    FeelsLikeGraph()
//}
