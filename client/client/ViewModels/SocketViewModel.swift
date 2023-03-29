//
//  SocketIOViewModel.swift
//  client
//
//  Created by sml on 28/03/23.
//

import Foundation
import SocketIO

final class SocketViewModel: ObservableObject {
    let manager = SocketManager(socketURL: URL(string: "url")!, config: [.log(true), .compress])
    
    @Published var socket: SocketIOClient
    @Published var images:[Data] = []

    init() {
        socket = manager.defaultSocket
        socket.on("connect") { (data, ack) in
            print("conectado")
        }
        
        socket.connect()
    }

}
