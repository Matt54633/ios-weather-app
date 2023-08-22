//
//  DayView.swift
//  Weather-App
//
//  Created by Matt Sullivan on 07/08/2023.
//

import SwiftUI
import WeatherKit

struct DayView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    let dayData: Forecast<DayWeather>.Element
    
    var body: some View {
        ZStack(alignment: .leading) {
            Background()
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                    VStack(alignment: .leading) {
                        HStack() {
                            Text(dayData.date.formatted(.dateTime.weekday(.wide)) + ", " +
                                 dayData.date.formatted(.dateTime.day()) + " " +
                                 dayData.date.formatted(.dateTime.month()))
                            .font(.largeTitle)
                            Spacer()
                            Image(systemName: dayData.symbolName)
                                .font(.title)
                        }
                        .fontWeight(.semibold)
                        Text(dayData.condition.description)
                    }
                    .padding(.bottom, 20)
                    TemperatureView(highTemperature: dayData.highTemperature.value,
                                    lowTemperature: dayData.lowTemperature.value)
                    SunriseSunsetView(sunrise: dayData.sun.sunrise, sunset: dayData.sun.sunset)
                    Spacer(minLength: 40)
                    if sizeClass == .compact {
                        CompactGraphs(dayData: dayData)
                    } else {
                        RegularGraphs(dayData: dayData)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .modifier(SymbolFill())
            .foregroundStyle(.white)
            .padding()
        }
    }
}

private struct CompactGraphs: View {
    let dayData: Forecast<DayWeather>.Element
    
    var body: some View {
        HStack {
            WindGraph(hourData: nil, dayData: dayData)
            Spacer(minLength: 20)
            RainInfoGraph(hourData: nil, dayData: dayData)
        }
        Spacer(minLength: 20)
        HStack {
            UVGraph(hourData: nil, dayData: dayData)
        }
    }
}

private struct RegularGraphs: View {
    let dayData: Forecast<DayWeather>.Element
    
    var body: some View {
        HStack {
            WindGraph(hourData: nil, dayData: dayData)
            Spacer(minLength: 20)
            RainInfoGraph(hourData: nil, dayData: dayData)
            Spacer(minLength: 20)
            UVGraph(hourData: nil, dayData: dayData)
        }
    }
}

private struct TemperatureView: View {
    let highTemperature: Double
    let lowTemperature: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(highTemperature.rounded(.toNearestOrEven).formatted())°")
                .font(.system(size: 64))
            Text("\(lowTemperature.rounded(.toNearestOrEven).formatted())°")
                .font(.system(size: 40))
        }
        .fontWeight(.semibold)
    }
}

private struct SunriseSunsetView: View {
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
