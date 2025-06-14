//
//  MusicPlayerApp.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 30.05.2025.
//

import SwiftUI

@main
struct MusicPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            //let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path())
            PlayerView()
        }
    }
}
