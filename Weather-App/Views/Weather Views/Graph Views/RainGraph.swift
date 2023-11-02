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
    @StateObject var weatherDataHelper = WeatherData.shared
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if let minuteForecast = weatherDataHelper.minuteForecast {
            if let hourlyForecast = weatherDataHelper.hourlyForecast {
                if ((hourlyForecast[0].precipitationChance * 100) > 0 && hourlyForecast[0].precipitationAmount.value > 0) {
                    VStack(alignment: .leading) {
                        Text("POSSIBLE PRECIPITATION")
                            .modifier(CalloutTextStyle())
                        VStack(alignment: .leading) {
                            Chart {
                                ForEach(minuteForecast [0...60], id: \.self.date) { minute in
                                    let precipitationValue = minute.precipitationIntensity.value
                                    let minuteValue = minute.date
                                    if sizeClass == .compact {
                                        BarMark(
                                            x: .value("Minute", minuteValue),
                                            y: .value("Precipitation", precipitationValue),
                                            width: 3
                                        )
                                        .cornerRadius(10)
                                    } else {
                                        BarMark(
                                            x: .value("Minute", minuteValue),
                                            y: .value("Precipitation", precipitationValue),
                                            width: 6
                                        )
                                        .cornerRadius(10)
                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 6, leading: 0, bottom: 0, trailing: 0))
                            .frame(height: 70)
                            .chartXAxis {
                                AxisMarks(values: .automatic) { _ in
                                    AxisTick(stroke: StrokeStyle(lineWidth: 3))
                                        .foregroundStyle(Color("Transparent"))
                                    AxisValueLabel()
                                        .foregroundStyle(.white)
                                }
                            }
                            .chartYAxis(.hidden)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.mint, .cyan]), startPoint: .top, endPoint: .bottom))
                        }
                        .modifier(GlassCard())
                        .modifier(SymbolFill())
                    }
                    if sizeClass == .compact {
                        Spacer(minLength: 20)
                    }
                }
            }
        }
    }
}

#Preview {
    RainGraph()
}
