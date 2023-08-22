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
                        .foregroundStyle(userLocationHelper.locationPermission ?? false ? Color.green : Color.red)
                    Text("Location Services \(userLocationHelper.locationPermission == true ? "Enabled" : "Disabled")")
                }
                Button(action: {
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL)
                    }
                }) {
                    HStack {
                        Image(systemName: "gear")
                            .foregroundStyle(Color(.darkPurple))
                        Text("Open System settings")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.gray)
                            .fontWeight(.semibold)
                            .font(.system(size: 14))
                    }
                    .foregroundColor(.black)
                }
            } header: {
                Text("Location Services")
            }
        }
        .modifier(NavigationBar())
        .navigationTitle("Settings")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
