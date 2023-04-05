//
//  WinnersViewModel.swift
//  client
//
//  Created by sml on 03/04/23.
//  
//

import SwiftUI


final class WinnersViewModel: ObservableObject {
    @Published var winners: [String] = []
    
    func teste() {
        print("back-next")
    }
}
