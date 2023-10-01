//
//  SelectMap.swift
//  Weather-App
//
//  Created by Matt Sullivan on 31/08/2023.
//

import SwiftUI

struct MapView: View {
    let isUserLocation: Bool
    let locationName: String

    var body: some View {
        if isUserLocation {
            UserLocationMap()
        } else {
            AddedLocationMap(locationName: locationName)
        }
    }
}

#Preview {
    MapView(isUserLocation: true, locationName: "Yeovil")
}
