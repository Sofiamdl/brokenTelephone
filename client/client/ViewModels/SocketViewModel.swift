//
//  SocketIOViewModel.swift
//  client
//
//  Created by sml on 28/03/23.
//

import Foundation
import SocketIO

final class SocketViewModel: ObservableObject {
    let manager = SocketManager(socketURL: URL(string: "https://7edd-150-161-70-2.ngrok-free.app")!, config: [.log(true), .compress])
    
    @Published var socket: SocketIOClient
    @Published var isHost: Bool = false
    @Published var images:[Data] = []
    @Published var gameRoom: String = ""
    @Published var joinedRoom: Bool = false
    
    init() {
        socket = manager.defaultSocket
        socket.on("connect") { (data, ack) in
            print("conectado")
        }
        
        socket.on("code") { (data, ack) in
            self.gameRoom = data[0] as? String ?? ""
            print("GAMEROOM: \(self.gameRoom)")
        }
        
        socket.on("joined") { (data, ack) in
            self.joinedRoom = data[0] as? Bool ?? false
            print(self.joinedRoom ? "Joined Room" : "Outro Codigo")
        }
        
        
        socket.connect()
    }

}
