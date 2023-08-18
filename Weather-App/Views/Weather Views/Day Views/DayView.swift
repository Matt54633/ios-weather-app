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
    let dayData: Slice<Forecast<DayWeather>>.Element
    
    var body: some View {
        ZStack(alignment: .leading) {
            Background()
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                    VStack(alignment: .leading) {
                        HStack() {
                            Text("\(dayData.date.formatted(.dateTime.weekday(.wide))), \(dayData.date.formatted(.dateTime.day())) \(dayData.date.formatted(.dateTime.month()))")
                                .font(.largeTitle)
                            Spacer()
                            Image(systemName: dayData.symbolName)
                                .symbolVariant(/*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .font(.title)
                        }
                        .fontWeight(.semibold)
                        Text(dayData.condition.description)
                    }
                    .padding(.bottom, 20)
                    VStack(alignment: .leading) {
                        Text("\(dayData.highTemperature.value.rounded(.toNearestOrEven).formatted())°")
                            .font(.system(size: 64))
                        Text("\(dayData.lowTemperature.value.rounded(.toNearestOrEven).formatted())°")
                            .font(.system(size: 40))
                    }
                    .fontWeight(.semibold)
                    HStack {
                        Group {
                            HStack {
                                Image(systemName: "sunrise.fill")
                                Text("\(dayData.sun.sunrise!.formatted(date: .omitted, time: .shortened))")
                            }
                            .help("Sunrise")
                            HStack {
                                Image(systemName: "sunset.fill")
                                Text("\(dayData.sun.sunset!.formatted(date: .omitted, time: .shortened))")
                            }
                            .help("Sunset")
                        }
                        .padding(10)
                        .background(Color("Transparent"))
                        .clipShape(RoundedRectangle(cornerRadius:20))
                        .shadow(radius: 5)
                    }
                    Spacer(minLength: 40)
                    if sizeClass == .compact {
                        HStack {
                            WindGraph(hourData: nil, dayData: dayData)
                            Spacer(minLength: 20)
                            RainInfoGraph(hourData: nil, dayData: dayData)
                        }
                        Spacer(minLength: 20)
                        HStack {
                            UVGraph(hourData: nil, dayData: dayData)
                        }
                    } else {
                        HStack {
                            WindGraph(hourData: nil, dayData: dayData)
                            Spacer(minLength: 20)
                            RainInfoGraph(hourData: nil, dayData: dayData)
                            Spacer(minLength: 20)
                            UVGraph(hourData: nil, dayData: dayData)
                        }
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .symbolRenderingMode(.multicolor)
            .foregroundStyle(.white)
            .fontDesign(.rounded)
            .padding()
        }
    }
}

//struct DayView_Previews: PreviewProvider {
//    static var previews: some View {
//        DayView()
//    }
//}
