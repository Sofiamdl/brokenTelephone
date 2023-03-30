//
//  ContentViewModel.swift
//  client
//
//  Created by sml on 28/03/23.
//  
//

import SwiftUI

// MARK: Variables to watch mark as Published. ViewModel also calls API/Core Data

final class ContentViewModel: ObservableObject {
    @Published var roomCodeArray = [RoomCodeTextfield(), RoomCodeTextfield(), RoomCodeTextfield(), RoomCodeTextfield()]
    
    func returnFinalCode() -> String {
        let code = roomCodeArray.map {
            $0.textBindingManager.text
        }
        let finalCode = "\(code[0])\(code[1])\(code[2])\(code[3])"
        return finalCode
        
    }

}
