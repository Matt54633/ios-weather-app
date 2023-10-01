//
//  Background.swift
//  Weather-App
//
//  Created by Matt Sullivan on 03/08/2023.
//

import SwiftUI

struct Background: View {
    var body: some View {
        LinearGradient(colors: [Color(.darkPurple), Color(.lilac)], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0.5, y: 0.6))
            .ignoresSafeArea(.all)
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
