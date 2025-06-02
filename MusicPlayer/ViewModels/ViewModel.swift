//
//  ViewModel.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 02.06.2025.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var songs: [SongModel] = [
        SongModel(name: "Love u babe", data:  Data(), artist: "Antonio", coverImage: Data(), duration: 0),
        SongModel(name: "Californication", data:  Data(), artist: "RHCP", coverImage: Data(), duration: 0),
        SongModel(name: "Forever ", data:  Data(), artist: "Antonio", coverImage: Data(), duration: 0)
    ]
}
