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
    @StateObject var userLocationHelper = LocationManager.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            if let location = userLocationHelper.placemark?.locality, let countryCode = userLocationHelper.placemark?.isoCountryCode {
                Text("\(location.uppercased()), \(countryCode.uppercased())")
                    .modifier(CalloutTextStyle())
            }
            Map(position: $position)
                .frame(minHeight: 200)
                .cornerRadius(25)
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                }
                .tint(Color(.lilac))
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

