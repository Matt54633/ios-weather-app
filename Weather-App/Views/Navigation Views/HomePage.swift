//
//  HomeList.swift
//  Weather-App
//
//  Created by Matt Sullivan on 03/08/2023.
//

import SwiftUI
import SwiftData

struct HomePage: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var userLocationHelper = LocationManager.shared
    @Query(sort: \location.creationDate, order: .reverse) private var locations: [location]
    
    var body: some View {
        ZStack {
            NavigationStack {
                Form {
                    Section {
                        NavigationLink {
                            WeatherLocation(locationName: "", fullLocationName: "")
                        } label: {
                            Image(systemName: "location")
                                .foregroundStyle(Color("Dark Purple"))
                            Text("Current Location")
                        }
                        NavigationLink {
                            FullMap()
                        } label: {
                            Image(systemName: "map")
                                .foregroundStyle(Color("Dark Purple"))
                            Text("Map")
                        }
                    } header: {
                        Text("Current Location")
                    }
                    Section {
                        NavigationLink {
                            SearchPage()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(Color("Dark Purple"))
                            
                            Text("Add location")
                        }
                    } header: {
                        Text("Add Location")
                    }
                    if locations.count != 0 {
                        Section {
                            List {
                                ForEach(locations) { location in
                                    NavigationLink {
                                        WeatherLocation(locationName: location.locationName, fullLocationName: location.fullLocationName)
                                    } label: {
                                        Image(systemName: "building.2.crop.circle")
                                            .foregroundStyle(Color("Dark Purple"))
                                        Text(location.locationName)
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
                        NavigationLink {
                            SettingsPage()
                        } label: {
                            HStack {
                                Image(systemName: "gear")
                                    .font(.title3)
                                    .foregroundStyle(Color("Dark Purple"))
                                Text("Settings")
                            }
                        }
                    } header: {
                        Text("Preferences")
                    }
                }
                .modifier(NavigationBar())
                .navigationTitle("Home")
            }
            .buttonBorderShape(.capsule)
        }
        .onAppear {
            userLocationHelper.requestPermission()
        }
    }
}

struct HomeList_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

