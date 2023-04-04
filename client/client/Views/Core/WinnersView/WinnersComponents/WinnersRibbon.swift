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
            Image(imageChooser())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
            CircleText(radius: 200, text: winner, kerning: 25)
                .rotationEffect(Angle(degrees: -35))
                .padding(.top, -35)
                .padding(.leading, -5)
            VStack {
                Text(textChooser())
                    .font(projectFont(style: .extraBold, size: 40))
                    .foregroundColor(Color.projectWhite)
                    .padding(.top, 246)
                    .padding(.leading, 20)
                Text("\(votes) votos")
                    .font(projectFont(style: .extraBold, size: 20))
                    .foregroundColor(Color.projectWhite)
            }

        }
    }
    
    func imageChooser() -> String {
        switch place {
        case .firstPlace:
            return "first-place"
        case .secondPlace:
            return "second-place"
        case .thirdPlace:
            return "third-place"
        }
    }
    
    func textChooser() -> String {
        switch place {
        case .firstPlace:
            return "1º"
        case .secondPlace:
            return "2º"
        case .thirdPlace:
            return "3º"
        }
    }

}
