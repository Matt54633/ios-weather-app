//
//  AddedLocationMap.swift
//  Weather-App
//
//  Created by Matt Sullivan on 15/08/2023.
//

import SwiftUI
import MapKit

struct AddedLocationMap: View {
    @ObservedObject var userLocationHelper = LocationManager.shared
    
    var searchMapPositionBinding: Binding<MapCameraPosition> {
        Binding {
            userLocationHelper.searchMapPosition ?? MapCameraPosition .region(MKCoordinateRegion())
        } set: { newValue in
            userLocationHelper.searchMapPosition = newValue
        }
    }
    
    var body: some View {
        Map(position: searchMapPositionBinding) {
            if let lat = searchMapPositionBinding.wrappedValue.region?.center.latitude, let lon = searchMapPositionBinding.wrappedValue.region?.center.longitude {
                Annotation("", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)) {
                    ZStack {
                        Circle()
                            .foregroundStyle(Color("Dark Purple"))
                        Image(systemName: "building.2.crop.circle")
                            .foregroundStyle(.white)
                            .font(.body)
                            .padding(5)
                    }
                }
            }
        }
        .tint(Color(.darkPurple))
        .frame(height: 200)
        .cornerRadius(25)
    }
}

//#Preview {
//    AddedLocationMap()
//}
