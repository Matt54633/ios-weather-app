//
//  VisibilityGraph.swift
//  Weather-App
//
//  Created by Matt Sullivan on 12/08/2023.
//

import SwiftUI
import WeatherKit

struct VisibilityGraph: View {
    let hourData: Slice<Forecast<HourWeather>>.Element
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "eye.fill")
                Text("Visibility")
            }
            Spacer()
            Text(hourData.visibility.formatted())
                .font(.system(size: 44))
                .fontWeight(.semibold)
            
            Spacer()
            Text("\(Int(hourData.cloudCover * 100))% Cloud Cover")
                .font(.system(size: 14))
        }
        .modifier(GlassCard())
        .modifier(SymbolFill())
    }
}

//#Preview {
//    VisibilityGraph()
//}
