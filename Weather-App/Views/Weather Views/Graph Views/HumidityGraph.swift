//
//  HumidityGraph.swift
//  Weather-App
//
//  Created by Matt Sullivan on 12/08/2023.
//

import SwiftUI
import WeatherKit

struct HumidityGraph: View {
    let hourData: Slice<Forecast<HourWeather>>.Element
    
    var body: some View {
        HStack {
                Image(systemName: "humidity.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.teal, .white)
                Text("Humidity")
            Spacer()
            Text("\(Int(hourData.humidity * 100))%")
                .font(.title)
                .fontWeight(.semibold)
        }
        .modifier(GlassCard())
    }
}

//#Preview {
//    HumidityGraph()
//}
