//
//  DayList.swift
//  Weather-App
//
//  Created by Matt Sullivan on 07/08/2023.
//

import SwiftUI

struct DayList: View {
    @StateObject var weatherDataHelper = WeatherData.shared
    
    var body: some View {
        if let dailyWeather = weatherDataHelper.dailyForecast {
            VStack(alignment: .leading) {
                Text("NEXT 10 DAYS")
                    .modifier(CalloutTextStyle())
                ForEach(dailyWeather.indices, id: \.self) { index in
                    let weatherEntry = dailyWeather[index]
                    VStack(alignment: .leading, spacing: 20) {
                        NavigationLink {
                            DayView(dayData: weatherEntry)
                        } label: {
                            HStack {
                                Text(isToday(weatherEntry.date) ? "Today" : weatherEntry.date.formatted(.dateTime.weekday(.abbreviated)))
                                    .fontWeight(.semibold)
                                    .frame(minWidth: 50)
                                Spacer()
                                Image(systemName: weatherEntry.symbolName)
                                    .modifier(SymbolFill())
                                    .frame(minWidth: 50)
                                Spacer()
                                HStack {
                                    Image(systemName: "chevron.up")
                                        .fontWeight(.bold)
                                        .font(.caption)
                                        .foregroundStyle(.yellow)
                                        .padding(-5)
                                    Text("\(weatherEntry.highTemperature.value.rounded(.toNearestOrEven).formatted())°")
                                }
                                .frame(minWidth: 50)
                                HStack {
                                    Image(systemName: "chevron.down")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.green)
                                        .padding(-5)
                                    Text("\(weatherEntry.lowTemperature.value.rounded(.toNearestOrEven).formatted())°")
                                }
                                .frame(minWidth: 50)
                            }
                        }
                    }
                    .padding(-5)
                    .modifier(RoundGlassCard())
                    
                    if index != dailyWeather.indices.last {
                        Color.clear
                            .frame(height: 0)
                    }
                }
            }
        }
    }
    
    private func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }
}

struct DayList_Previews: PreviewProvider {
    static var previews: some View {
        DayList()
    }
}
