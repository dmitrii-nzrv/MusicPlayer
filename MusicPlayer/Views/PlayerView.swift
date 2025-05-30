//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 30.05.2025.
//

import SwiftUI

struct PlayerView: View {
    var body: some View {
        ZStack{
            BackgroundView()
            
            List{
                HStack{
                    Color.white
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading){
                        Text("Hurt")
                            .nameFont()
                        Text("Johnny Cash")
                            .artistFont()
                    }
                    
                    Spacer()
                    
                    Text("03:48")
                }
            }
            
            .listStyle(.plain)
        }
        
    }
}

#Preview {
    PlayerView()
}


