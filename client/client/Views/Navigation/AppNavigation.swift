//
//  AppNavigation.swift
//  client
//
//  Created by sml on 28/03/23.
//

import SwiftUI
import Charts

struct AppCore: View {
            
    var body: some View {
        NavigationStack {
            selectScreen
        }
    }
    
    private var selectScreen: some View {
        ContentView()
            .navigationDestination(for: Route.self){ route in
                switch route {
                case .home:
                    ContentView()
                }
            }
    }
}
