//
//  HourList.swift
//  Weather-App
//
//  Created by Matt Sullivan on 07/08/2023.
//

import SwiftUI

struct HourList: View {
    @ObservedObject var weatherDataHelper = WeatherData.shared
    
    var body: some View {
        if let hourlyWeather = weatherDataHelper.hourlyForecast {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(hourlyWeather, id: \.self.date) { weatherEntry in
                        NavigationLink {
                            HourView(hourData: weatherEntry)
                        } label : {
                            VStack {
                                Text(DateFormatter.localizedString(from: weatherEntry.date, dateStyle: .none, timeStyle: .short))
                                    .fontWeight(.semibold)
                                Spacer(minLength: 10)
                                Image(systemName: weatherEntry.symbolName)
                                    .symbolVariant(/*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                    .symbolRenderingMode(.multicolor)
                                Spacer(minLength: 10)
                                Text("\(weatherEntry.temperature.value.rounded(.toNearestOrEven).formatted())°")
                            }
                        }
                    }
                }
            }
            .padding()
            .background(Color("Transparent"))
            .clipShape(RoundedRectangle(cornerRadius:20))
            .shadow(radius: 5)
        }
    }
}

struct HourList_Previews: PreviewProvider {
    static var previews: some View {
        HourList()
    }
}
