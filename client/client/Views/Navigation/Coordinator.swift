//
//  Coordinator.swift
//  client
//
//  Created by mvitoriapereirac on 30/03/23.
//

import SwiftUI

class Coordinator: ObservableObject {

    @Published var path: [Route] = []

    func gotoBackOnepage() {
        path.removeLast(1)
    }
    
    func gotoHomePage() {
        path.removeLast(path.count)
    }

    func goToHomePage() {
        path.append(Route.home)
    }
    
    func goToLoadingPage() {
        path.append(Route.loadingRoom)
    }
    
    func goToGameRoom(){
        path.append(Route.gameRoom)
    }
    
    

}
