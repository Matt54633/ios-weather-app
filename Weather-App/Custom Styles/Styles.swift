//
//  Styles.swift
//  Weather-App
//
//  Created by Matt Sullivan on 22/08/2023.
//

import SwiftUI

struct GlassCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color("Transparent"))
            .clipShape(RoundedRectangle(cornerRadius:20))
            .shadow(radius: 5)
    }
}

struct NavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color("Lilac"),for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct SymbolFill: ViewModifier {
    func body(content: Content) -> some View {
        content
            .symbolVariant(/*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .symbolRenderingMode(.multicolor)
    }
}

struct RainGaugeStyle: GaugeStyle {
    private var blueGradient = LinearGradient(gradient: Gradient(colors: [.mint, .cyan]), startPoint: .leading, endPoint: .trailing)
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color(.transparent), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(135))

            Circle()
                .trim(from: 0, to: 0.75 * configuration.value)
                .stroke(blueGradient, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(135))

            VStack {
                configuration.currentValueLabel
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                Text("%")
                    .font(.system(size: 14, design: .rounded))
            }
        }
        .frame(width: 100, height: 100)
    }
}
