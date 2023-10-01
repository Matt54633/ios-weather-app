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
        HStack {
            Image(systemName: "eye.fill")
            Text("Visibility")
            Spacer(minLength: 15)
            Text(hourData.visibility.formatted())
                .font(.title)
                .fontWeight(.semibold)
        }
        .modifier(GlassCard())
        .modifier(SymbolFill())
    }
}

//#Preview {
//    VisibilityGraph()
//}
