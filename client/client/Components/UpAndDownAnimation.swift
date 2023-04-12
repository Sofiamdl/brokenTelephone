//
//  UpAndDownAnimation.swift
//  client
//
//  Created by mvitoriapereirac on 12/04/23.
//
import SwiftUI

struct MoveAnimation: View {
    @State private var isMovingUp = true
    
    var body: some View {
        Image("guarana")
            .resizable()
            .scaledToFit()
            .frame(width: 400, height: 400)
            .offset(y: isMovingUp ? -100 : 100)
            .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true))
            .onAppear() {
                self.isMovingUp.toggle()
            }
    }
}

