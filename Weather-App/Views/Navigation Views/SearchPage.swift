//
//  SearchPage.swift
//  Weather-App
//
//  Created by Matt Sullivan on 03/08/2023.
//

import SwiftUI
import CoreLocation
import MapKit

struct SearchPage: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @State private var searchString: String = ""
    @State private var searchLocationCoords: CLLocation = CLLocation(latitude: 0, longitude: 0)
    @State private var locationNames: [MKPlacemark] = []
    @State private var searchFailed: Bool = false
    
    var body: some View {
        List {
            Section {
                ForEach(locationNames,  id: \.self) { location in
                    if let locationName = location.name, let subLocality = location.subAdministrativeArea, let country = location.countryCode {
                        HStack {
                            HStack {
                                Text("\(locationName), \(subLocality), \(country)")
                                    .foregroundStyle(.black)
                            }
                            Spacer()
                            Image(systemName: "plus")
                                .foregroundStyle(Color("Dark Purple"))
                        }
                        .onTapGesture {
                            geocode(locationName: "\(locationName), \(country)", fullLocationName: "\(locationName), \(subLocality), \(country)")
                        }
                        .alert(isPresented: $searchFailed) {
                            Alert(title: Text("Invalid Map Location"), message: Text("Please try refining your search area"), dismissButton: .default(Text("Got it!")))
                       }
                    }
                }
            } header: {
                Text("")
                    .padding(-20)
            }
        }
        .searchable(text: $searchString, placement: .navigationBarDrawer(displayMode: .always), prompt: "Yeovil, GB")
        .autocorrectionDisabled()
        .onChange(of: searchString) {
            searchRequest()
        }
        .navigationTitle("Add Location")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(Color("Lilac"),for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .foregroundStyle(.white)
        .fontDesign(.rounded)
    }
    
    func geocode(locationName: String, fullLocationName: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(fullLocationName, completionHandler: { (placemarks, error) in
            if error != nil {
                searchFailed = true
                return
            }
            
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
                        
            if let location = location {
                searchLocationCoords = location
                addLocation(locationName: locationName, fullLocationName: fullLocationName, context: context)
                dismiss()
            }
            else {}
        })
    }
    
    func searchRequest() {
        locationNames.removeAll()
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchString
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            for item in response.mapItems {
                locationNames.append(item.placemark)
            }
        }
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
    }
}
