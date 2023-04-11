//
//  UsersAvailable.swift
//  client
//
//  Created by mvitoriapereirac on 10/04/23.
//

import SwiftUI

struct AvailableUsers: View {
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var socket: SocketViewModel
    
    let column = [GridItem(.flexible())]
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.gameRoomBackground
                    .ignoresSafeArea()            
                VStack(spacing: 24) {
                    UsersGrid(roomCode: socket.gameRoom, userName: $socket.users)
                        .frame(width: geo.size.width/2, height: geo.size.height/1.3)
                        .cornerRadius(20)
                        .shadow(radius: 20)
                    if (socket.isHost) {
                        OrangeButton(buttonLabel: "Começar jogo") {
                            socket.socket.emit("play", socket.gameRoom)
                            coordinator.goTo(view: .gameRoom)
                        }
                    } else {
                        Text("Esperando o Host começar a partida...")
                    }
                  
                }
            }
            .onChange(of: socket.timeStarted, perform: { timeStarted in
                if timeStarted == true {
                    coordinator.goTo(view: .gameRoom)
                }
            })
        }
    }
    
    
}


