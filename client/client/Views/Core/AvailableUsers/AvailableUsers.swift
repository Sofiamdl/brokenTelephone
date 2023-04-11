//
//  UsersAvailable.swift
//  client
//
//  Created by mvitoriapereirac on 10/04/23.
//

import SwiftUI

struct AvailableUsers: View {
    let coordinador = Coordinator()
    @State var usersArray: [String]
    @EnvironmentObject var socket: SocketViewModel
    var gameRoomCode: String

    public init(roomcode: String, usersArray: [String]) {
        self.gameRoomCode = roomcode
        self.usersArray = usersArray
        self.gameRoomCode = socket.gameRoom
    }
    
    let column = [GridItem(.flexible())]

    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Color.gameRoomBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    UsersGrid(roomCode: gameRoomCode, userName: $socket.users)
                    .frame(width: geo.size.width/2, height: geo.size.height/1.3)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    
                    OrangeButton(buttonLabel: "Começar jogo") {
                        print("öi")
                    }
                }
                

                }

                

                
                
            }
        }
        

}

struct AvailableUsersViewContent_Previews: PreviewProvider {
    static var previews: some View {
        AvailableUsers(roomcode: "12345", usersArray: ["barreto", "laula", "mavi", "sofia", "matheus"])
    }
}
