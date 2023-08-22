//
//  WindGraph.swift
//  Weather-App
//
//  Created by Matt Sullivan on 12/08/2023.
//

import SwiftUI
import Charts
import WeatherKit

struct WindGraph: View {
    @ObservedObject var weatherDataHelper = WeatherData.shared
    let hourData: Slice<Forecast<HourWeather>>.Element?
    let dayData: Slice<Forecast<DayWeather>>.Element?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "wind")
                Text("Wind")
            }
            Spacer()
            
            if let maxWindSpeed = maxWindSpeed {
                ZStack {
                    Circle()
                        .stroke(style: .init(lineWidth: 8.0, dash: [2, 5]))
                        .foregroundStyle(Color(.transparent))
                        .frame(width: 100, height: 100)
                    Image("arrow")
                        .rotationEffect(Angle(degrees: (hourData?.wind.direction.value ?? dayData?.wind.direction.value) ?? 0))
                        .font(.system(size: 10))
                    Circle()
                        .frame(width: 65, height: 65)
                        .foregroundStyle(Color(.lightPurple))
                    VStack {
                        Text((hourData?.wind.speed.formatted().dropLast(4) ?? dayData?.wind.speed.formatted().dropLast(4) ?? ""))
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                        Text("mph")
                            .font(.system(size: 12))
                    }
                }
                Spacer()
                Text(dayData != nil ? "\(Int(maxWindSpeed)) mph winds during the day" : "\(Int(maxWindSpeed)) mph is the strongest wind today")
                    .font(.system(size: 14))
            } else {
                Text("No wind data available")
                    .foregroundColor(.gray)
            }
        }
        .modifier(GlassCard())
        .modifier(SymbolFill())
    }
    
    private var maxWindSpeed: Double? {
        if let hourData = hourData {
            return weatherDataHelper.hourlyForecast?.max(by: { $0.wind.speed.value < $1.wind.speed.value })?.wind.speed.value ?? hourData.wind.speed.value
        } else if let dayData = dayData {
            return dayData.wind.speed.value
        }
        
        return nil // Provide a default return value if neither hourData nor dayData is available
    }
}

//
//#Preview {
//    WindGraph()
//}
