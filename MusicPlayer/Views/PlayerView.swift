//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 30.05.2025.
//

import SwiftUI
import RealmSwift

// MARK: ~ PlayerView
struct PlayerView: View {
    // MARK: ~ Properties
    @ObservedResults(SongModel.self) var songs
    @StateObject var vm = ViewModel()
    @State private var showFiles = false
    @State private var showFullPlayer = false
    @Namespace var playAnimation
    
    var frameImage: CGFloat {
        showFullPlayer ? 320 : 50
    }
    
    // MARK: ~ Body
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack {
                    // MARK: ~ List of songs
                    List {
                        ForEach(songs) { song in
                            SongCell(song: song, durationFormatted: vm.durationFormatted)
                                .onTapGesture {
                                    vm.playAudio(song: song)
                                }
                        }
                        .onDelete(perform: $songs.remove)
                    }
                    .listStyle(.plain)
                    Spacer()
                    // MARK: ~ Player
                    if vm.currentSong != nil {
                        Player()
                            .frame(height: showFullPlayer ? SizeConstant.fullPlayer : SizeConstant.miniPlayer)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    self.showFullPlayer.toggle()
                                }
                            }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFiles.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                }
            }
            .sheet(isPresented: $showFiles) {
                ImportFileManager()
            }
        }
    }
    
    // MARK: ~ Player View
    @ViewBuilder
    private func Player() -> some View {
        VStack {
            // Mini player
            HStack {
                SongImageView(imageData: vm.currentSong?.coverImage, size: frameImage)
                if !showFullPlayer {
                    VStack(alignment: .leading) {
                        SongDescription()
                    }
                    .matchedGeometryEffect(id: "Description", in: playAnimation)
                    Spacer()
                    CustomButton(image: vm.isPlaying ? "pause.fill" : "play.fill", size: .title) {
                        vm.playPause()
                    }
                }
            }
            .padding()
            .background(showFullPlayer ? .clear : .black.opacity(0.3))
            .cornerRadius(10)
            .padding()
            // Full player
            if showFullPlayer {
                VStack {
                    SongDescription()
                }
                .matchedGeometryEffect(id: "Description", in: playAnimation)
                .padding(.top)
                VStack {
                    // duration
                    HStack {
                        Text("\(vm.durationFormatted(vm.currentTime))")
                        Spacer()
                        Text("\(vm.durationFormatted(vm.totalTime))")
                    }
                    .durationFont()
                    .padding()
                    // slider
                    Slider(value: $vm.currentTime, in: 0...vm.totalTime) { editing in
                        if !editing {
                            vm.seekAudio(time: vm.currentTime)
                        }
                    }
                    .offset(y: -18)
                    .tint(.white)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            vm.updateProgress()
                        }
                    }
                    HStack(spacing: 40) {
                        CustomButton(image: "backward.end.fill", size: .title2) {
                            vm.backward()
                        }
                        CustomButton(image: vm.isPlaying ? "pause.circle.fill" : "play.circle.fill", size: .largeTitle) {
                            vm.playPause()
                        }
                        CustomButton(image: "forward.end.fill", size: .title2) {
                            vm.forward()
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
    }
    
    // MARK: ~ Custom Button
    private func CustomButton(image: String, size: Font, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .foregroundStyle(.white)
                .font(size)
        }
    }
    
    // MARK: ~ Song Description
    @ViewBuilder
    private func SongDescription() -> some View {
        if let currentSong = vm.currentSong {
            Text(currentSong.name)
                .nameFont()
            Text(currentSong.artist ?? "unknown artist")
                .artistFont()
        }
    }
}

#Preview {
    PlayerView()
}



