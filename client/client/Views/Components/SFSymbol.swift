//
//  SFSymbol.swift
//  client
//
//  Created by sml on 02/04/23.
//

import SwiftUI

struct SFSymbol: View {
    let name: String
    let color: Color?
    let size: CGFloat?
    let weight: Font.Weight?
    
    var body: some View {
        Image(systemName: name)
            .foregroundColor(color ?? Color.projectWhite)
            .font(.system(size: size ?? 60, weight: weight ?? .light))
    }

}
