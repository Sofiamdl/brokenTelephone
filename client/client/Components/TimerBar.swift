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
    
    @Binding var height: CGFloat

    var body: some View {
        HStack(spacing: 0) {
            
            
            Rectangle()
                .fill(Color.projectOrange)
                .frame(width: orangeBarWidth, height: height/10)
            
            
            Rectangle()
                .fill(Color.fontColor)
                .frame(width: yellowBarWidth, height: height/10, alignment: .trailing)
        }
        
    }
}
