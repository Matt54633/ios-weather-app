//
//  HourView.swift
//  Weather-App
//
//  Created by Matt Sullivan on 06/08/2023.
//

import SwiftUI
import WeatherKit

struct HourView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    let hourData: Forecast<HourWeather>.Element
    
    var body: some View {
        ZStack(alignment: .leading) {
            Background()
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                    VStack(alignment: .leading) {
                        HStack {
                            Text(DateFormatter.localizedString(from: hourData.date, dateStyle: .none, timeStyle: .short))
                                .font(.largeTitle)
                            Spacer()
                            Image(systemName: hourData.symbolName)
                                .font(.title)
                        }
                        .fontWeight(.semibold)
                        Text(hourData.condition.description)
                    }
                    .padding(.bottom, 15)
                    Text("\(hourData.temperature.value.rounded(.toNearestOrEven).formatted())°")
                        .font(.system(size: 64))
                        .fontWeight(.semibold)
                        .padding(.bottom, 35)
                    
                    if sizeClass == .compact {
                        CompactGraphs(hourData: hourData)
                    } else {
                        RegularGraphs(hourData: hourData)
                    }
                }
                .toolbarBackground(.hidden, for: .navigationBar)
                .modifier(SymbolFill())
                .foregroundStyle(.white)
                .padding()
            }
        }
    }
}

private struct CompactGraphs: View {
    let hourData: Forecast<HourWeather>.Element
    
    var body: some View {
        HStack {
            WindGraph(hourData: hourData, dayData: nil)
            Spacer(minLength: 20)
            RainInfoGraph(hourData: hourData, dayData: nil)
        }
        Spacer(minLength: 20)
        HStack {
            UVGraph(hourData: hourData, dayData: nil)
            Spacer(minLength: 20)
            VisibilityGraph(hourData: hourData)
        }
        Spacer(minLength: 20)
        HStack {
            FeelsLikeGraph(hourData: hourData)
            Spacer(minLength: 20)
            HumidityGraph(hourData: hourData)
        }
    }
}

private struct RegularGraphs: View {
    let hourData: Forecast<HourWeather>.Element
    
    var body: some View {
        HStack {
            WindGraph(hourData: hourData, dayData: nil)
            Spacer(minLength: 20)
            RainInfoGraph(hourData: hourData, dayData: nil)
            Spacer(minLength: 20)
            UVGraph(hourData: hourData, dayData: nil)
        }
        Spacer(minLength: 20)
        HStack {
            VisibilityGraph(hourData: hourData)
            Spacer(minLength: 20)
            FeelsLikeGraph(hourData: hourData)
            Spacer(minLength: 20)
            HumidityGraph(hourData: hourData)
        }
    }
}

//struct HourView_Previews: PreviewProvider {
//    static var previews: some View {
//        HourView(hourData: Forecast<HourWeather>.Element(date: Date(), temperature: Measurement(value: 20, unit: .celsius), symbolName: "sun.max.fill", condition: .clear))
//    }
//}
