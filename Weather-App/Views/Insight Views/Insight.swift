//
//  Insight.swift
//  Weather-App
//
//  Created by Matt Sullivan on 25/08/2023.
//

import SwiftUI

struct Insight: View {
    let title: String
    let value: String
    let unit: String?
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 55, height: 55)
                    .rotationEffect(Angle(degrees: 45))
                    .foregroundColor(Color(.transparent))
                VStack {
                    Text(value)
                        .font(.title2)
                        .bold()
                    if let unitValue = unit {
                        Text(unitValue)
                            .font(.caption)
                            .padding(.top, -15)
                    }
                }
            }
            Spacer()
            Text(title)
                .font(.system(size: 13))
        }
    }
}

#Preview {
    Insight(title: "Max Wind", value: "30", unit: "mph")
}
