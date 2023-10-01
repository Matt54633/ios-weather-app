//
//  HourView.swift
//  Weather-App
//
//  Created by Matt Sullivan on 06/08/2023.
//

import SwiftUI
import WeatherKit

struct CompactHourView: View {
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
                    
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 15)], spacing: 15) {
                        WindGraph(hourData: hourData, dayData: nil)
                        RainInfoGraph(hourData: hourData, dayData: nil)
                        UVGraph(hourData: hourData, dayData: nil)
                        VisibilityGraph(hourData: hourData)
                        FeelsLikeGraph(hourData: hourData)
                        HumidityGraph(hourData: hourData)
                    }
                }
                .toolbarBackground(.hidden, for: .navigationBar)
                .modifier(SymbolFill())
                .foregroundStyle(.white)
                .padding(.init(top: 15, leading: 15, bottom: 0, trailing: 15))
            }
        }
    }
}
