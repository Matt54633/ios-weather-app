//
//  MapView.swift
//  Weather-App
//
//  Created by Matt Sullivan on 03/08/2023.
//

import SwiftUI
import MapKit

struct UserLocationMap: View {
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Map(position: $position)
            .frame(minHeight: 200)
            .cornerRadius(25)
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            .tint(Color(.darkPurple))
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

