//
//  RegularDayView.swift
//  Weather-App
//
//  Created by Matt Sullivan on 31/08/2023.
//

import SwiftUI
import WeatherKit

struct RegularDayView: View {
    let dayData: Forecast<DayWeather>.Element
    
    var body: some View {
        ZStack(alignment: .leading) {
            Background()
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer(minLength: 50)
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
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)], spacing: 15) {
                        WindGraph(hourData: nil, dayData: dayData)
                        RainInfoGraph(hourData: nil, dayData: dayData)
                        UVGraph(hourData: nil, dayData: dayData)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .modifier(SymbolFill())
            .foregroundStyle(.white)
            .padding(.init(top: 40, leading: 40, bottom: 0, trailing: 40))
        }
    }
}
