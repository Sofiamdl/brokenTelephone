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

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            selectScreen
        }
        .environmentObject(coordinator)
    }
    
    private var selectScreen: some View {
        ContentView()
            .navigationDestination(for: Route.self){ route in
                switch route {
                case .home:
                    ContentView()
                case .loadingRoom:
                    LoadingRoomView()
                case .gameRoom:
                    RoomView()
                }
                }
            }
    
}
