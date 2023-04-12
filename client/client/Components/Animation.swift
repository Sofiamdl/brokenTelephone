//
//  Animation.swift
//  client
//
//  Created by mvitoriapereirac on 11/04/23.
//

import SwiftUI

struct GifAnimationView: View {
    
    var imageName: String
    var imageLastIndex: Int // ultimo index img
    
    let imageNames = ["image1", "image2", "image3"]
    let moveIncrement = 1.0
    
    @State private var frameIndex = 0
    
    var body: some View {
        if imageName != "guarana" {
            Image(imageName + "\(frameIndex)")
                .resizable()
                .frame(width: 420, height: 248)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever()) {
                        frameIndex += 1

    //
                    }
                }
                .onChange(of: frameIndex) { newIndex in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            if frameIndex < imageLastIndex {
                                frameIndex += 1
                            } else {
                                frameIndex = 0 // Número total de imagens na sequência
                            }
                            
                        }
                    }
                    
                }
        }
        else {
            GeometryReader { geo in
                Image("guarana")
                    .resizable()
                    .frame(width: 420, height: 248)
                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
            }
            
            
        }
        
    }
}
