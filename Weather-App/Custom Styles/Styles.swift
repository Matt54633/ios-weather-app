//
//  Styles.swift
//  Weather-App
//
//  Created by Matt Sullivan on 22/08/2023.
//

import Foundation
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
