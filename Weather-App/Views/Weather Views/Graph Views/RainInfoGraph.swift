//
//  RainInfoGraph.swift
//  Weather-App
//
//  Created by Matt Sullivan on 14/08/2023.
//

import SwiftUI
import WeatherKit

struct RainInfoGraph: View {
    let hourData: Slice<Forecast<HourWeather>>.Element?
    let dayData: Slice<Forecast<DayWeather>>.Element?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "cloud.rain.fill")
                    .symbolRenderingMode(.multicolor)
                Text("Rainfall")
            }
            Spacer()
            
            if let data = hourData {
                if data.precipitationAmount.value > 0 {
                    Text("\(data.precipitationAmount.value.formatted()) mm")
                        .font(.system(size: 44))
                        .fontWeight(.semibold)
                    Spacer()
                    Text("Amount of rain")
                        .font(.system(size: 14))
                } else {
                    Gauge(value: (data.precipitationChance * 100), in: 0.0...100.0) {
                        Text("%")
                            .foregroundStyle(.white)
                    } currentValueLabel: {
                        Text("\(Int(data.precipitationChance * 100))")
                            .foregroundStyle(.white)
                    }
                    .scaleEffect(1.6)
                    .frame(maxWidth: .infinity)
                    .gaugeStyle(.accessoryCircular)
                    .tint(LinearGradient(gradient: Gradient(colors: [.mint, .cyan]), startPoint: .leading, endPoint: .trailing))
                    Spacer()
                    Text("Chance of rain")
                        .font(.system(size: 14))
                }
            } else if let data = dayData {
                if data.precipitationAmount.value > 0 {
                    Text("\(data.precipitationAmount.value.formatted()) mm")
                        .font(.system(size: 44))
                        .fontWeight(.semibold)
                    Spacer()
                    Text("Amount of rain")
                        .font(.system(size: 14))
                } else {
                    Gauge(value: (data.precipitationChance * 100), in: 0.0...100.0) {
                        Text("%")
                            .foregroundStyle(.white)
                    } currentValueLabel: {
                        Text("\(Int(data.precipitationChance * 100))")
                            .foregroundStyle(.white)
                    }
                    .scaleEffect(1.6)
                    .frame(maxWidth: .infinity)
                    .gaugeStyle(.accessoryCircular)
                    .tint(LinearGradient(gradient: Gradient(colors: [.mint, .cyan]), startPoint: .leading, endPoint: .trailing))
                    Spacer()
                    Text("Chance of rain")
                        .font(.system(size: 14))
                }
            } else {
                Text("No rain data available")
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
//    RainInfoGraph()
//}
