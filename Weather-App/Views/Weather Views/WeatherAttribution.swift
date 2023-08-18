//
//  WeatherAttribution.swift
//  Weather-App
//
//  Created by Matt Sullivan on 07/08/2023.
//

import SwiftUI
import WeatherKit

struct WeatherAttribution: View {
    @State private var attributionLogo: URL?
    @State private var attributionURL: URL?
    
    var body: some View {
        AsyncImage(url: attributionLogo) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 20)
        } placeholder: {
            ProgressView()
        }
        .task {
            do {
                let attribution = try await WeatherService.shared.attribution
                let attributionLink = attribution.legalPageURL
                self.attributionURL = attributionLink
                let attributionLogo = attribution.combinedMarkDarkURL
                self.attributionLogo = attributionLogo
            } catch {
                print("failed to load attribution")
            }
        }
        if let attributionURL {
            Link(destination: attributionURL, label : {
                Text("Other data sources")
                    .font(.system(size: 12))
                    .underline()
            })
        }
    }
}

struct WeatherAttribution_Previews: PreviewProvider {
    static var previews: some View {
        WeatherAttribution()
    }
}
