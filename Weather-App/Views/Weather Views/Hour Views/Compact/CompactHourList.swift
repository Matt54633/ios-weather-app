//
//  HourList.swift
//  Weather-App
//
//  Created by Matt Sullivan on 07/08/2023.
//

import SwiftUI

struct CompactHourList: View {
    @StateObject var weatherDataHelper = WeatherData.shared

    var body: some View {
        if let hourlyWeather = weatherDataHelper.hourlyForecast {
            VStack(alignment: .leading) {
                Text("NEXT 24 HOURS")
                    .modifier(CalloutTextStyle())
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(hourlyWeather, id: \.self.date) { weatherEntry in
                            NavigationLink {
                                CompactHourView(hourData: weatherEntry)
                            } label : {
                                VStack {
                                    Text(DateFormatter.localizedString(from: weatherEntry.date, dateStyle: .none, timeStyle: .short))
                                        .fontWeight(.semibold)
                                    Spacer(minLength: 10)
                                    Image(systemName: weatherEntry.symbolName)
                                        .modifier(SymbolFill())
                                    Spacer(minLength: 10)
                                    Text("\(weatherEntry.temperature.value.rounded(.toNearestOrEven).formatted())°")
                                }
                            }
                        }
                    }
                }
                .modifier(GlassCard())
            }
        }
    }
}

struct HourList_Previews: PreviewProvider {
    static var previews: some View {
        CompactHourList()
    }
}
