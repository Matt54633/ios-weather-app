//
//  RainGraph.swift
//  Weather-App
//
//  Created by Matt Sullivan on 12/08/2023.
//

import SwiftUI
import Charts
import WeatherKit

struct RainGraph: View {
    @ObservedObject var weatherDataHelper = WeatherData.shared
    
    var body: some View {
        if let minuteForecast = weatherDataHelper.minuteForecast {
            if let hourlyForecast = weatherDataHelper.hourlyForecast {
                if ((hourlyForecast[0].precipitationChance * 100) > 0 && hourlyForecast[0].precipitationAmount.value > 0) {
                 
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "cloud.rain.fill")
                            Text("Possible Precipitation")
                        }
                        Chart {
                            ForEach(minuteForecast [0...60], id: \.self.date) { minute in
                                let precipitationValue = minute.precipitationIntensity.value
                                let minuteValue = minute.date
                                BarMark(
                                    x: .value("Minute", minuteValue),
                                    y: .value("Precipitation", precipitationValue),
                                    width: 3
                                )
                                .cornerRadius(10)
                            }
                        }
                        .frame(height: 70)
                        .chartXAxis {
                            AxisMarks(values: .automatic) { _ in
                                AxisTick(stroke: StrokeStyle(lineWidth: 2))
                                    .foregroundStyle(Color("Transparent"))
                                AxisValueLabel()
                                    .foregroundStyle(.white)
                            }
                        }
                        .chartYAxis {
                            AxisMarks(values: .automatic(desiredCount: 4)) { _ in
                                AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [3, 2]))
                                    .foregroundStyle(Color("Transparent"))
                                AxisValueLabel()
                                    .foregroundStyle(.white)
                            }
                        }
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.mint, .cyan]), startPoint: .top, endPoint: .bottom))
                    }
                    .modifier(GlassCard())
                    .modifier(SymbolFill())
                }
            }
        }
    }
}

#Preview {
    RainGraph()
}
