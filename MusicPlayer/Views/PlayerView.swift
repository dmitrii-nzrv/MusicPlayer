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
    @State private var showFiles = false
    @State private var showFullPlayer = false
    @Namespace var playAnimation
    
    
    var frameImage: CGFloat {
        showFullPlayer ? 320 : 50
    }
    
    
    // MARK: ~ Body
    var body: some View {
        NavigationStack {
            ZStack{
                BackgroundView()
                
                VStack {
                    List {
                        ForEach(vm.songs){ song in
                            SongCell(song: song, durationFormatted: vm.durationFormatted)
                                .onTapGesture {
                                    vm.playAudio(song: song)
                                }
                        }
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
            
            // MARK: ~ NavBar
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
            
            // MARK: ~ File's sheet
            .sheet(isPresented: $showFiles) {
                ImportFileManager(songs: $vm.songs)
            }
            
        }
    }
    
    // MARK: ~ Methods
    @ViewBuilder
    private func Player() -> some View {
        VStack {
            
            /// Mini player
            HStack {
                // image cover
                if let data = vm.currentSong?.coverImage, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: frameImage, height: frameImage)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    ZStack{
                        Color.gray
                            .frame(width: 60, height: 60)
                        Image(systemName: "music.note")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .foregroundStyle(.white)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
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
            
            /// Full player
            if showFullPlayer {
                VStack{
                    SongDescription()
                }
                .matchedGeometryEffect(id: "Description", in: playAnimation)
                .padding(.top)
                
                VStack{
                    /// duration
                    HStack{
                        Text("\(vm.durationFormatted(vm.currentTime))")
                        Spacer()
                        Text("\(vm.durationFormatted(vm.totalTime))")
                    }
                    .durationFont()
                    .padding()
                    
                    /// slider
                    Slider(value: $vm.currentTime, in:  0...vm.totalTime) { editing in                        
                        if !editing {
                            vm.seekAudio(time: vm.currentTime)
                        }
                    }
                    .offset(y: -18)
                    .tint(.white)
                    .onAppear() {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            vm.updateProgress()
                        }
                    }
                    
                    HStack(spacing: 40) {
                        CustomButton(image: "backward.end.fill", size: .title2) {
                            //
                        }
                        CustomButton(image: "play.circle.fill", size: .largeTitle) {
                            //
                        }
                        CustomButton(image: "forward.end.fill", size: .title2) {
                            //
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
    }
    
    private func CustomButton(image: String, size: Font, action: @escaping () ->()) -> some View{
        Button {
            action()
        } label: {
            Image(systemName: image)
                .foregroundStyle(.white)
                .font(size)
        }

    }
    
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



