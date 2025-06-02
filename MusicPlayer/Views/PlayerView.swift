//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 30.05.2025.
//

import SwiftUI

struct PlayerView: View {
    var body: some View {
        ZStack{
            BackgroundView()
            
            List{
                SongCell()
            }
            .listStyle(.plain)
        }
        
    }
}

#Preview {
    PlayerView()
}



