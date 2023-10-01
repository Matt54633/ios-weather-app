//
//  RegularHomePage.swift
//  Weather-App
//
//  Created by Matt Sullivan on 31/08/2023.
//

import SwiftUI
import SwiftData

struct RegularHomePage: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var userLocationHelper = LocationManager.shared
    @Query(sort: \location.creationDate, order: .reverse) private var locations: [location]
//    @State private var columnVisibility = NavigationSplitViewVisibility.detailOnly
    
    private func navigationLinkLabel(imageName: String, text: String) -> some View {
        HStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
    
    var body: some View {
        NavigationSplitView {
            Form {
                Section {
                    NavigationLink(destination: RegularWeatherLocation(locationName: "", fullLocationName: "")) {
                        navigationLinkLabel(imageName: "location", text: "Current Location")
                    }
                    NavigationLink(destination: FullMap()) {
                        navigationLinkLabel(imageName: "map", text: "Map")
                    }
                } header: {
                    Text("Current Location")
                }
                
                Section {
                    NavigationLink(destination: SearchPage()) {
                        navigationLinkLabel(imageName: "plus", text: "Add Location")
                    }
                } header: {
                    Text("Add Location")
                }
                
                if !locations.isEmpty {
                    Section {
                        List {
                            ForEach(locations) { location in
                                NavigationLink(
                                    destination: RegularWeatherLocation(locationName: location.locationName, fullLocationName: location.fullLocationName)
                                ) {
                                    navigationLinkLabel(imageName: "building.2.crop.circle", text: location.locationName)
                                }
                            }
                            .onDelete { indexes in
                                for index in indexes {
                                    deleteLocation(location: locations[index], context: context)
                                }
                            }
                        }
                    } header: {
                        Text("Saved Locations")
                    }
                }

                Section {
                    NavigationLink(destination: SettingsPage()) {
                        navigationLinkLabel(imageName: "gear", text: "Settings")
                    }
                } header: {
                    Text("Preferences")
                }
            }
            .tint(Color(.lilac))
            .onAppear {
                userLocationHelper.requestPermission()
            }
            .navigationTitle("Home")
        } detail: {
            RegularWeatherLocation(locationName: "", fullLocationName: "")
        }
    }
}

struct RegularHomePage_Previews: PreviewProvider {
    static var previews: some View {
        RegularHomePage()
    }
}
