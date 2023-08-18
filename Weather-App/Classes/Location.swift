//
//  Location.swift
//  Weather-App
//
//  Created by Matt Sullivan on 07/08/2023.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class location: Identifiable {
    var id: String
    var locationName: String
    var fullLocationName: String
    var creationDate: Date
    
    init(locationName: String, fullLocationName: String) {
        self.id = UUID().uuidString
        self.locationName = locationName
        self.fullLocationName = fullLocationName
        self.creationDate = Date()
    }
}

func addLocation(locationName: String, fullLocationName: String, context: ModelContext) {
    let location = location(locationName: locationName, fullLocationName: fullLocationName)
    context.insert(location)
}

func deleteLocation(location: location, context: ModelContext) {
    context.delete(location)
}
