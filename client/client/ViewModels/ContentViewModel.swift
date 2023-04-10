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
    @Published var fieldArray = [Field.firstCharacter, Field.secondCharacter, Field.thirdCharacter, Field.fourthCharacter, Field.dismissKeyboard]
    @Published var showingAlert = false

    
    func returnFinalCode() -> String {
        let code = roomCodeMap()
        let finalCode = "\(code[0])\(code[1])\(code[2])\(code[3])"
        if areFieldsValid(){
            //n precisa
            return finalCode
        }
        
        return ""
    }
    
    func isFieldValid(field: RoomCodeTextfield) -> Bool {
        if field.textBindingManager.text != "" {
            return true
        }
        return false
    }
    
    func areFieldsValid() -> Bool {
        let codeArray = roomCodeMap()

        for item in codeArray {
            if item == "" || item == " " {

                return false
            }
        }
        return true
        
    }
    
    func roomCodeMap() -> [String] {
        let codeArray = roomCodeArray.map {
            $0.textBindingManager.text
        }
        return codeArray

        
    }

}
