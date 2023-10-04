//
//  FullMap.swift
//  Weather-App
//
//  Created by Matt Sullivan on 15/08/2023.
//

import SwiftUI
import MapKit

struct FullMap: View {
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        VStack {
            Map(position: $position)
                .ignoresSafeArea(.all)
                .tint(Color(.lilac))
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

//#Preview {
//    FullMap()
//}
