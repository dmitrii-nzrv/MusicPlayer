//
//  BackgroundView.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 30.05.2025.
//

import SwiftUI

// MARK: ~ BackgroundView
struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [
                .topBG, .midBG, .bottomBG
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

