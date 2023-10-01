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
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

struct RoundGlassCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color("Transparent"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

struct GlassCapsule: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(alignment: .center)
            .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
            .background(Color("Transparent"))
            .clipShape(RoundedRectangle(cornerRadius: 200))
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
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
                .stroke(Color(.transparent), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(135))

            Circle()
                .trim(from: 0, to: 0.75 * configuration.value)
                .stroke(blueGradient, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(135))

            VStack {
                configuration.currentValueLabel
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
            }
        }
        .frame(width: 35, height: 35)
    }
}

struct CalloutTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundStyle(Color(.darkTransparent))
            .padding(.leading, 15)
    }
}
