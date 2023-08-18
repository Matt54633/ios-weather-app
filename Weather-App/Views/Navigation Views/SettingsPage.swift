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
    @State private var locationPermissionStatus: String = ""
    @State private var permissionColour: Color = .red
    
    var body: some View {
        List {
            Section {
                HStack {
                    Image(systemName: "location")
                        .foregroundStyle(Color(permissionColour))
                    Text("Location Services \(locationPermissionStatus)")
                }
                Button(action: openSettings) {
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
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(Color("Lilac"),for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle("Settings")
        .onAppear {
            locationEnabled()
        }
    }
    
    func openSettings() {
        openURL(URL(string: UIApplication.openSettingsURLString)!)
    }
    
    func locationEnabled() {
        if userLocationHelper.locationManager.authorizationStatus == .authorizedAlways || userLocationHelper.locationManager.authorizationStatus == .authorizedWhenInUse {
            locationPermissionStatus = "Enabled"
            permissionColour = .green
        } else {
            locationPermissionStatus = "Disabled"
            permissionColour = .red
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
