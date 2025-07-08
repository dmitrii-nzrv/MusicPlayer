//
//  ImportFileManager.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 02.06.2025.
//

import Foundation
import SwiftUI
import AVFoundation
import RealmSwift

struct ImportFileManager: UIViewControllerRepresentable {
    // MARK: ~ Coordinator
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // MARK: ~ UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .open)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    // MARK: ~ Coordinator Class
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        // MARK: ~ Properties
        var parent: ImportFileManager
        @ObservedResults(SongModel.self) var songs
        
        // MARK: ~ Init
        init(parent: ImportFileManager) {
            self.parent = parent
        }
        
        // MARK: ~ UIDocumentPickerDelegate
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
            defer { url.stopAccessingSecurityScopedResource() }
            do {
                let document = try Data(contentsOf: url)
                let asset = AVAsset(url: url)
                var song = SongModel(name: url.lastPathComponent, data: document)
                let metadata = asset.metadata
                for item in metadata {
                    guard let key = item.commonKey?.rawValue, let value = item.value else { continue }
                    switch key {
                    case AVMetadataKey.commonKeyArtist.rawValue:
                        song.artist = value as? String
                    case AVMetadataKey.commonKeyArtwork.rawValue:
                        song.coverImage = value as? Data
                    case AVMetadataKey.commonKeyTitle.rawValue:
                        song.name = value as? String ?? song.name
                    default:
                        break
                    }
                }
                song.duration = CMTimeGetSeconds(asset.duration)
                let isDuplicate = songs.contains { $0.name == song.name && $0.artist == song.artist }
                if !isDuplicate {
                    $songs.append(song)
                } else {
                    print("the song already exists")
                }
            } catch {
                print("Error processing the file \(error)")
            }
        }
    }
}
