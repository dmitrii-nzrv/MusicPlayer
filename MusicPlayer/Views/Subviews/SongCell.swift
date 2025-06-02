//
//  SongCell.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 30.05.2025.
//

import SwiftUI

struct SongCell: View {
    // MARK: ~ Properties
    let song: SongModel
     
    // MARK: ~ Body
    var body: some View {
        HStack{
            Color.white
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            
            VStack(alignment: .leading){
                Text(song.name)
                    .nameFont()
                Text(song.artist ?? "Unknown artist")
                    .artistFont()
            }
            
            Spacer()
            
            Text("03:48")
                .artistFont()
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}


