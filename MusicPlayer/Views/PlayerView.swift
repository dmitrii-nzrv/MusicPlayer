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
    @State private var showFullPlayer = true
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
                    VStack {
                        
                        /// Mini player
                        HStack {
                            Color.white
                                .frame(width: frameImage, height: frameImage)
                            
                            if !showFullPlayer {
                                VStack(alignment: .leading) {
                                    Text("song.name")
                                        .nameFont()
                                    Text("kaka")
                                        .artistFont()
                                }
                                .matchedGeometryEffect(id: "Description", in: playAnimation)
                                
                                Spacer()
                                
                                CustomButton(image: "play.fill", size: .title) {
                                    //
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
                                Text("song.name")
                                    .nameFont()
                                Text("kaka")
                                    .artistFont()
                            }
                            .matchedGeometryEffect(id: "Description", in: playAnimation)
                            .padding(.top)
                            
                            VStack{
                                /// duration
                                HStack{
                                    Text("00 00")
                                    Spacer()
                                    Text("00 00")
                                }
                                .durationFont()
                                .padding()
                                
                                /// slider
                                Divider()
                                
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
                    .frame(height: showFullPlayer ? SizeConstant.fullPlayer : SizeConstant.miniPlayer)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            self.showFullPlayer.toggle()
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
    private func CustomButton(image: String, size: Font, action: @escaping () ->()) -> some View{
        Button {
            action()
        } label: {
            Image(systemName: image)
                .foregroundStyle(.white)
                .font(size)
        }

    }
}

#Preview {
    PlayerView()
}



