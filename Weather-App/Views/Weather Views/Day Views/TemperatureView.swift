//
//  TemperatureView.swift
//  Weather-App
//
//  Created by Matt Sullivan on 31/08/2023.
//

import SwiftUI

struct TemperatureView: View {
    let highTemperature: Double
    let lowTemperature: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(highTemperature.rounded(.toNearestOrEven).formatted())°")
                .font(.system(size: 64))
            Text("\(lowTemperature.rounded(.toNearestOrEven).formatted())°")
                .font(.system(size: 40))
        }
        .fontWeight(.semibold)
    }
}
