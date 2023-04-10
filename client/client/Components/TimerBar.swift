//
//  TimerBar.swift
//  client
//
//  Created by mvitoriapereirac on 04/04/23.
//

import SwiftUI

struct TimerBar: View {
    @Binding var orangeBarWidth: Double
    @Binding var yellowBarWidth: Double
    
    
    var body: some View {
        HStack(spacing: 0) {
            
            
            Rectangle()
                .fill(Color.projectOrange)
                .frame(width: orangeBarWidth, height: 58)
            
            
            Rectangle()
                .fill(Color.fontColor)
                .frame(width: yellowBarWidth, height: 58, alignment: .trailing)
        }
        
    }
}
