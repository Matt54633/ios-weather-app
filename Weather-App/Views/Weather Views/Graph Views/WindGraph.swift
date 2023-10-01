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
    @StateObject var weatherDataHelper = WeatherData.shared
    let hourData: Slice<Forecast<HourWeather>>.Element?
    let dayData: Slice<Forecast<DayWeather>>.Element?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "wind")
                    Text("Wind")
                    Spacer()
                    Image(systemName: "location.north.circle.fill")
                        .symbolRenderingMode(.monochrome)
                        .font(.title3)
                        .rotationEffect(Angle(degrees: (hourData?.wind.direction.value ?? dayData?.wind.direction.value) ?? 0))
                    Text((hourData?.wind.speed.formatted() ?? dayData?.wind.speed.formatted() ?? ""))
                        .font(.title)
                        .fontWeight(.semibold)
                }
//                Spacer()
//                if let maxWindSpeed = maxWindSpeed {
//                    Text(dayData != nil ? "\(Int(maxWindSpeed)) mph winds during the day" : "\(Int(maxWindSpeed)) mph is the strongest wind today")
//                        .font(.system(size: 14))
//                } else {
//                    Text("No wind data available")
//                        .foregroundColor(.gray)
//                }
//                
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
