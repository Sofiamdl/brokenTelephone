//
//  RoomViewModel.swift
//  client
//
//  Created by mvitoriapereirac on 04/04/23.
//

import SwiftUI

class RoomViewModel: ObservableObject {
    @Published var currentLine = Line()
    @Published var lines: [Line] = []
    @Published var selectedColor: Color = Color.projectRed
    @Published var timerBarWidth = 936.0
    @Published var timerBarWidthOrange = 936.0
    @Published var timerBarWidthYellow = 0.0
    @Published var timeRemaining = 300 // 30s * 10
    @Published var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @Published var timerBarDiminish = 3.14 //942 divided by 300
    @Published var gameStatus: GameStatus = .userIsDrawing
    @Published var userGuess = ""
    
    
    func timerWentZero() -> Bool {
        if timeRemaining == 0 {
            self.timeRemaining = 300
            self.timerBarWidthYellow = 0.0
            self.timerBarWidthOrange = timerBarWidth
            return true
        }
        return false
    }
    
    func timeSubtraction() {
        if self.timeRemaining > 0 {
            self.timerBarWidthOrange -= timerBarDiminish
            self.timerBarWidthYellow += timerBarDiminish
            self.timeRemaining -= 1
            
        }
    }
    
    func gameModeChange() {
        if gameStatus == .userIsDrawing {
           gameStatus = .userIsGuessing
        } else {
            gameStatus = .userIsDrawing
        }
    }
    
    func reset() {
        currentLine = Line()
        lines = []
        selectedColor = Color.projectRed
        timerBarWidth = 936.0
        timerBarWidthOrange = 936.0
        timerBarWidthYellow = 0.0
        timeRemaining = 300 // 30s * 10
        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        timerBarDiminish = 3.14 //942 divided by 300
        gameStatus = .userIsDrawing
        userGuess = ""
    }
    
    func changeTimeBarDiminish() {
        self.timerBarDiminish = timerBarWidth / 300
    }
    
}
