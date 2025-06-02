//
//  ViewModel.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 02.06.2025.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var songs: [SongModel] = []
}
