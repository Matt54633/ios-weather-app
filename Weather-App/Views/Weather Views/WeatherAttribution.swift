//
//  WeatherAttribution.swift
//  Weather-App
//
//  Created by Matt Sullivan on 07/08/2023.
//

import SwiftUI
import WeatherKit

struct WeatherAttribution: View {
    @StateObject var weatherDataHelper = WeatherData.shared
    
    var body: some View {
        VStack {
            if let attributionLogo = weatherDataHelper.attributionLogo,
               let attributionURL = weatherDataHelper.attributionURL {
                AsyncImage(url: attributionLogo) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 20)
                } placeholder: {
                    ProgressView()
                }
                Link(destination: attributionURL, label : {
                    Text("Other data sources")
                        .font(.system(size: 12))
                        .underline()
                })
            }
        }
    }
}

struct WeatherAttribution_Previews: PreviewProvider {
    static var previews: some View {
        WeatherAttribution()
    }
}
