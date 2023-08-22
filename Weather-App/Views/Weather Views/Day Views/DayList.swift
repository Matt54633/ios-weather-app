//
//  DayList.swift
//  Weather-App
//
//  Created by Matt Sullivan on 07/08/2023.
//

import SwiftUI

struct DayList: View {
    @ObservedObject var weatherDataHelper = WeatherData.shared
    
    var body: some View {
        if let dailyWeather = weatherDataHelper.dailyForecast {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "calendar.badge.clock")
                    Text("The Week Ahead")
                }
                Divider()
                    .overlay(.white)
                VStack(alignment: .trailing) {
                    ForEach(dailyWeather, id: \.self.date) { weatherEntry in
                        NavigationLink {
                            DayView(dayData: weatherEntry)
                        } label: {
                            HStack {
                                Text(weatherEntry.date.formatted(.dateTime.weekday(.abbreviated)))
                                    .fontWeight(.semibold)
                                    .frame(minWidth: 50)
                                Spacer()
                                Image(systemName: weatherEntry.symbolName)
                                    .modifier(SymbolFill())
                                    .frame(minWidth: 50)
                                Spacer()
                                Text("\(weatherEntry.highTemperature.value.rounded(.toNearestOrEven).formatted())° | \(weatherEntry.lowTemperature.value.rounded(.toNearestOrEven).formatted())°")
                                    .frame(minWidth: 80)
                            }
                            .padding(5)
                        }
                    }
                }
            }
            .modifier(GlassCard())
        }
    }
}

struct DayList_Previews: PreviewProvider {
    static var previews: some View {
        DayList()
    }
}
