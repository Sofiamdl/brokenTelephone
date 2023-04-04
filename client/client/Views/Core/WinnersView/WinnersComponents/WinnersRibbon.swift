//
//  WinnersRibbon.swift
//  client
//
//  Created by sml on 03/04/23.
//

import SwiftUI

struct WinnersRibbon: View {
    let winner: String
    let image: String
    let place: ResultEnum
    let votes: String
    
    var body: some View {
        ZStack(alignment: .top){
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .cornerRadius(200)
                .padding(.top, 10)
            Image(teste())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
            CircleText(radius: 200, text: winner, kerning: 25)
                .rotationEffect(Angle(degrees: -35))
                .padding(.top, -35)
                .padding(.leading, -5)

        }
    }
    
    func teste() -> String {
        switch place {
        case .firstPlace:
            return "first-place"
        default:
            return "first-place"
        }
    }

}
