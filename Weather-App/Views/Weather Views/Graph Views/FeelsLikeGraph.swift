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
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "thermometer.medium")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.red, .white)
                Text("Feels Like")
            }
            Spacer()
            Text("\(hourData.apparentTemperature.value.rounded(.toNearestOrEven).formatted())°")
                .font(.system(size: 44))
                .fontWeight(.semibold)
            Spacer()
            Group {
                if hourData.apparentTemperature.value.rounded(.toNearestOrEven) > hourData.temperature.value.rounded(.toNearestOrEven) {
                    Text("Warmer than actual temperature")
                } else if hourData.apparentTemperature.value.rounded(.toNearestOrEven) < hourData.temperature.value.rounded(.toNearestOrEven)  {
                    Text("Cooler than actual temperature")
                } else {
                    Text("Similar to actual temperature")
                }
            }
            .font(.system(size: 14))
        }
        .modifier(GlassCard())
    }
}

//#Preview {
//    FeelsLikeGraph()
//}
