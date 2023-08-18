//
//  HumidityGraph.swift
//  Weather-App
//
//  Created by Matt Sullivan on 12/08/2023.
//

import SwiftUI
import WeatherKit

struct HumidityGraph: View {
    let hourData: Slice<Forecast<HourWeather>>.Element
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "humidity.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.teal, .white)
                Text("Humidity")
            }
            Spacer()
            Text("\(Int(hourData.humidity * 100))%")
                .font(.system(size: 44))
                .fontWeight(.semibold)
            Spacer()
            Text("The current dew point is \(hourData.dewPoint.value.rounded(.toNearestOrAwayFromZero).formatted())°")
                .font(.system(size: 14))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color("Transparent"))
        .clipShape(RoundedRectangle(cornerRadius:20))
        .shadow(radius: 5)
    }
    
}

//#Preview {
//    HumidityGraph()
//}
