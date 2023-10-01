//
//  RegularHourList.swift
//  Weather-App
//
//  Created by Matt Sullivan on 31/08/2023.
//

import SwiftUI
import WeatherKit

struct RegularHourList: View {
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
                                RegularHourView(hourData: weatherEntry)
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
//
//#Preview {
//    RegularHourList()
//}
