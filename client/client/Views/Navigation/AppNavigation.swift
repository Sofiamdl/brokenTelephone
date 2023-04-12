//
//  AppNavigation.swift
//  client
//
//  Created by sml on 28/03/23.
//

import SwiftUI
import Charts

struct AppNavigation: View {
    @ObservedObject var coordinator = Coordinator()
    @ObservedObject var socket = SocketViewModel()
    @ObservedObject var room = RoomViewModel()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            selectScreen
        }
        .environmentObject(coordinator)
        .environmentObject(socket)
        .environmentObject(room)
        .navigationBarBackButtonHidden(true)
    }
    
    private var selectScreen: some View {
        HomeView()
            .navigationDestination(for: Route.self){ route in
                switch route {
                case .home:
                    HomeView()
                case .loadingRoom:
                    LoadingRoomView()
                case .gameRoom:
                    RoomView().navigationBarHidden(true)
                case .threadsView:
                    ThreadView().navigationBarHidden(true)
                case .availableUsers:
                    AvailableUsers().navigationBarHidden(true)
                }
            }
    }
    
}
