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
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var searchString: String = ""
    @State private var locationNames: [MKPlacemark] = []
    @State private var searchFailed: Bool = false
    @State private var searchSucceeded: Bool = false
    @State private var locationNameVar: String = ""
    @State private var fullLocationNameVar: String = ""
    
    var body: some View {
        List {
            Section {
                ForEach(locationNames, id: \.self) { location in
                    LocationRow(placemark: location, searchFailed: $searchFailed, searchSucceeded: $searchSucceeded) {
                        geocode(locationName: location.formattedName, geocodeLocation: location.geocodeLocation)
                    }
                }
            } header: {
                Text("")
                    .padding(-20)
            }
        }
        .searchable(text: $searchString, placement: .navigationBarDrawer(displayMode: .always), prompt: "London, GB")
        .autocorrectionDisabled()
        .onChange(of: searchString) {
            searchRequest()
        }
        .navigationTitle("Add Location")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func geocode(locationName: String, geocodeLocation: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(geocodeLocation) { placemarks, error in
            if error != nil {
                searchFailed = true
            } else if (placemarks?.first) != nil {
                addLocation(locationName: locationName, fullLocationName: geocodeLocation, context: context)
                searchSucceeded = true
                
                locationNameVar = locationName
                fullLocationNameVar = geocodeLocation
            }
        }
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

struct LocationRow: View {
    let placemark: MKPlacemark
    @Binding var searchFailed: Bool
    @Binding var searchSucceeded: Bool
    let onAdd: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Text(placemark.formattedFullLocation)
            Spacer()
            Image(systemName: "plus")
                .foregroundStyle(Color(.lilac))
        }
        .onTapGesture(perform: onAdd)
        .alert(isPresented: $searchFailed) {
            Alert(title: Text("Invalid Map Location"), message: Text("Please try refining your search area"), dismissButton: .default(Text("Got it!")))
        }
        .alert(isPresented: $searchSucceeded) {
            Alert(title: Text("Location added successfully"), dismissButton: .default(Text("Got it!"), action: { dismiss() }))
        }
    }
}

extension MKPlacemark {
    var formattedName: String {
        [name, countryCode].compactMap { $0 }.joined(separator: ", ")
    }
    
    var formattedFullLocation: String {
        [name, subAdministrativeArea, countryCode].compactMap { $0 }.joined(separator: ", ")
    }
    
    var geocodeLocation: String {
        [name, postalCode, countryCode].compactMap { $0 }.joined(separator: ", ")
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
    }
}
