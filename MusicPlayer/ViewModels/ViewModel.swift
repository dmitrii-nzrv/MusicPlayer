//
//  ViewModel.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 02.06.2025.
//

import Foundation
import AVFAudio

class ViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    // MARK: ~ Properties
    @Published var songs: [SongModel] = []
    @Published var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var currentIndex: Int?
    @Published var currentTime: TimeInterval = 0.0
    @Published var totalTime: TimeInterval = 0.0
    
    
    
    var currentSong: SongModel? {
        guard let currentIndex = currentIndex, songs.indices.contains(currentIndex) else { return nil }
        return songs[currentIndex]
    }
    
    // MARK: ~ Methods
    func playAudio(song: SongModel){
        do {
            self.audioPlayer = try AVAudioPlayer(data: song.data)
            self.audioPlayer?.delegate = self
            self.audioPlayer?.play()
            isPlaying = true
            totalTime = audioPlayer?.duration ?? 0.0
            if let index = songs.firstIndex(where: { $0.id == song.id} ) {
                currentIndex = index
            }
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func forward() {
        guard let currentIndex = currentIndex else { return }
        let nextIndex = currentIndex + 1 < songs.count ? currentIndex + 1 : 0
        playAudio(song: songs[nextIndex])
    }
    
    func backward() {
        guard let currentIndex = currentIndex else { return }
        let previusIndext = currentIndex > 0 ? currentIndex - 1 : songs.count - 1
        playAudio(song: songs[previusIndext])
    }
    
    func durationFormatted(_ duration: Double) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func playPause() {
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isPlaying.toggle()
    }
    
    func seekAudio(time: TimeInterval) {
        audioPlayer?.currentTime = time
    }
    
    func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil 
        isPlaying = false
    }
    
    func updateProgress() {
        guard let player = audioPlayer else { return }
        currentTime = player.currentTime
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            forward()
        }
    }
    
    func delete(offsets: IndexSet) {
        if let first = offsets.first {
            stopAudio()
            songs.remove(at: first)
        }
    }
}
