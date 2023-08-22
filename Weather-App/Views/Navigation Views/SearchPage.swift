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
    @State private var locationNames: [MKPlacemark] = []
    @State private var searchFailed: Bool = false
    
    var body: some View {
        List {
            Section {
                ForEach(locationNames, id: \.self) { location in
                    LocationRow(placemark: location, searchFailed: $searchFailed) {
                        geocode(locationName: location.formattedName, geocodeLocation: location.geocodeLocation)
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
        .modifier(NavigationBar())
        .navigationTitle("Add Location")
    }
    
    func geocode(locationName: String, geocodeLocation: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(geocodeLocation) { placemarks, error in
            if error != nil {
                searchFailed = true
            } else if (placemarks?.first) != nil {
                addLocation(locationName: locationName, fullLocationName: geocodeLocation, context: context)
                dismiss()
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
    let onAdd: () -> Void
    
    var body: some View {
        HStack {
            Text(placemark.formattedFullLocation)
                .foregroundStyle(.black)
            Spacer()
            Image(systemName: "plus")
                .foregroundStyle(Color("Dark Purple"))
        }
        .onTapGesture(perform: onAdd)
        .alert(isPresented: $searchFailed) {
            Alert(title: Text("Invalid Map Location"), message: Text("Please try refining your search area"), dismissButton: .default(Text("Got it!")))
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
        [locality, subAdministrativeArea, countryCode].compactMap { $0 }.joined(separator: ", ")
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
    }
}
