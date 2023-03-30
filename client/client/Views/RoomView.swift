//
//  RoomView.swift
//  client
//
//  Created by mvitoriapereirac on 30/03/23.
//

import SwiftUI

struct RoomView: View {
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        Color.gameRoomBackground
    }
    
    
}
struct RoomViewContent_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
    }
}
