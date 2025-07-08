//
//  FontsView.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 30.05.2025.
//

import SwiftUI

// MARK: ~ DurationFontModifier
struct DurationFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.system(size: 14, weight: .light, design: .rounded))
    }
}

// MARK: ~ Extensions
extension View {
    func durationFont() -> some View {
        self.modifier(DurationFontModifier())
    }
}

extension Text {
    func nameFont() -> some View {
        self
            .foregroundStyle(.white)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
    }
    
    func artistFont() -> some View {
        self
            .foregroundStyle(.white)
            .font(.system(size: 14, weight: .light, design: .rounded))
    }
}


