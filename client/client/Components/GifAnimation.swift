//
//  Animation.swift
//  client
//
//  Created by mvitoriapereirac on 11/04/23.
//

import SwiftUI

struct GifAnimationView: View {
    
    let imageName: String
    let imageLastIndex: Int // ultimo index img
    let frameSize: CGSize
    
    
    
    @State private var frameIndex = 0
    
    var body: some View {
        
        Image(imageName + "\(frameIndex)")
            .resizable()
            .frame(width: frameSize.width, height: frameSize.height)
            .onAppear {
                withAnimation(.linear(duration: 0.2).repeatForever()) {
                    frameIndex += 1
                    
                    
                }
            }
            .onChange(of: frameIndex) { newIndex in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.linear(duration: 0.2)) {
                        if frameIndex < imageLastIndex {
                            frameIndex += 1
                        } else {
                            frameIndex = 0 // Número total de imagens na sequência
                        }
                        
                    }
                }
                
            }
        
        
        
    }
}
