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
    @Published var fieldArray = [Field.firstCharacter, Field.secondCharacter, Field.thirdCharacter, Field.fourthCharacter]
    
    func returnFinalCode() -> String {
        let code = roomCodeMap()
        let finalCode = "\(code[0])\(code[1])\(code[2])\(code[3])"
        if isFieldValid(){
            //n precisa
            return finalCode
        }
        
        return ""
    }
    
    func isFieldValid() -> Bool {
        let codeArray = roomCodeMap()
        if codeArray.count != 4 {
            print("sou falso")
            return false
        }
        for item in codeArray {
            if item == "" || item == " " {
                print("sou falso2")

                return false
            }
        }        
        print("souvdd")
        return true
        
    }
    
    func roomCodeMap() -> [String] {
        let codeArray = roomCodeArray.map {
            $0.textBindingManager.text
        }
        return codeArray

        
    }

}
