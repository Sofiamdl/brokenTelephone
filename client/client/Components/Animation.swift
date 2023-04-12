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
    
    
    @State private var frameIndex = 0
    
    var body: some View {
        Image("\(imageName)\(frameIndex)")
            .resizable()
            .frame(width: 420, height: 248)
            .onAppear {
                print("äasa")
                withAnimation(.easeInOut(duration: 1.0).repeatForever()) {
                    print("ta aq")
                    frameIndex += 1

//                    if frameIndex < imageLastIndex {
//                    }
                }
            }
            .onChange(of: frameIndex) { newIndex in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        if frameIndex < imageLastIndex {
                            print("3")
                            frameIndex += 1
                        } else {
                            print("4")
                            frameIndex = 0 // Número total de imagens na sequência
                        }
                        
                    }
                }
                
            }
    }
}
