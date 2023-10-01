//
//  UVGraph.swift
//  Weather-App
//
//  Created by Matt Sullivan on 12/08/2023.
//

import SwiftUI
import WeatherKit

struct UVGraph: View {
    let hourData: Slice<Forecast<HourWeather>>.Element?
    let dayData: Slice<Forecast<DayWeather>>.Element?
    
    var body: some View {
        HStack {
            Image(systemName: "thermometer.sun.fill")
            Text("UV")
            Spacer(minLength: 50)
            if let uvValue = hourData?.uvIndex.value ?? dayData?.uvIndex.value {
                Gauge(value: Double(uvValue), in: 0.0...12.0) {
                    Text("UV")
                }
                .frame(maxWidth: 125 )
                .gaugeStyle(.accessoryLinear)
                .tint(Color(.transparent))
                Text(uvValue.formatted())
                    .font(.title)
                    .fontWeight(.semibold)
            } else {
                Text("No UV data available")
                    .foregroundColor(.gray)
            }
        }
        .modifier(GlassCard())
        .modifier(SymbolFill())
    }
}

//#Preview {
//    UVGraph()
//}
