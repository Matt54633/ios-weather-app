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
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "thermometer.sun.fill")
                    .symbolRenderingMode(.multicolor)
                Text("UV Index")
            }
            Spacer()
            if let uvValue = hourData?.uvIndex.value ?? dayData?.uvIndex.value {
                HStack {
                    Text(uvValue.formatted())
                        .font(.system(size: 44))
                        .fontWeight(.semibold)
                    Spacer()
                    Text("")
                }
                Spacer()
                Gauge(value: Double(uvValue), in: 0.0...12.0) {
                    Text("UV")
                }
                .gaugeStyle(.accessoryLinear)
                .tint(LinearGradient(colors: [.green, .orange, .red], startPoint: .leading, endPoint: .trailing))
            } else {
                Text("No UV data available")
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("Transparent"))
        .clipShape(RoundedRectangle(cornerRadius:20))
        .shadow(radius: 5)
    }
}

//#Preview {
//    UVGraph()
//}
