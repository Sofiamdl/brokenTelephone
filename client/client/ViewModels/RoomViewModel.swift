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
    @Published var timerBarWidthOrange = 942.0
    @Published var timerBarWidthYellow = 0.0
    @Published var timeRemaining = 300 // 30s * 10
    @Published var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @Published var timerBarDiminish = 3.14 //942 divided by 300
    
    
}
