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
    @Published var users: [String] = []
    @Published var timeStarted: Bool = false
    @Published var timeout: Bool = false
    @Published var currentPhrase: String = ""
    @Published var currentImage: Data = Data()

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
        
        socket.on("new_player") { (data, ack) in
            self.users.append(data[0] as? String ?? "")
            print(self.users)
        }
        
        socket.on("start-timer") { (data, ack) in
            self.timeStarted = true
            print(self.timeStarted)
        }
        
        socket.on("timeout") { (data, ack) in
            self.timeout = true
            print(self.timeout)
        }
        
        socket.on("phrase") { (data, ack) in
            self.currentPhrase = data[0] as? String ?? ""
            print(self.currentPhrase)
        }
        
        socket.on("drawing") { (data, ack) in
            if let buffer = data[0] as? String {
                let dataDecoded : Data = Data(base64Encoded: buffer, options: .ignoreUnknownCharacters)!
                self.currentImage = dataDecoded
            }
        }
        
        
        socket.connect()
    }
    
}
