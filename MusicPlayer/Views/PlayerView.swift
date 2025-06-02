//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 30.05.2025.
//

import SwiftUI

struct PlayerView: View {
    // MARK: ~ Properties
    @StateObject var vm = ViewModel()
    
    // MARK: ~ Body
    var body: some View {
        NavigationStack {
            ZStack{
                BackgroundView()
                
                List {
                    ForEach(vm.songs){ song in
                        SongCell(song: song)
                    }
                }
                .listStyle(.plain)
            }
            // MARK: ~ NavBar
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }

                }
            }
        }
    }
}

#Preview {
    PlayerView()
}



