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
    
    func popView(view: Route) {
        for element in path {
            if element == view {
                path.remove(at:(path.firstIndex(of: element) ?? 0))
            }
        }
    }
    
    func gotoHomePage() {
        path.removeLast(path.count)
    }

    func goTo(view: Route) {
        path.append(view)
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
