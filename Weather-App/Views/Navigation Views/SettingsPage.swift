//
//  Settings.swift
//  Weather-App
//
//  Created by Matt Sullivan on 06/08/2023.
//

import SwiftUI

struct SettingsPage: View {
    @Environment(\.openURL) var openURL
    @ObservedObject var userLocationHelper = LocationManager.shared
    
    var body: some View {
        List {
            Section {
                HStack {
                    Image(systemName: "location")
                        .foregroundColor(userLocationHelper.locationPermission == true ? .green : .red)
                    Text("Location Services \(userLocationHelper.locationPermission == true ? "Enabled" : "Disabled")")
                }
                Button(action: openSystemSettings) {
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(Color(.lilac))
                        Text("Open System Settings")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .font(.system(size: 14))
                    }
                }
            } header: {
                Text("Location Services")
            }
        }
        .navigationTitle("Settings")
    }
    
    func openSystemSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
