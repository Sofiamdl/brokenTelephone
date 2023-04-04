//
//  WinnersView.swift
//  client
//
//  Created by sml on 03/04/23.
//  
//

import SwiftUI

struct WinnersView: View {
    @ObservedObject private var viewModel = WinnersViewModel()
       
    var body: some View {
        ZStack {
            PageBackground(backFunction: viewModel.teste, nextFunction: viewModel.teste)
            VStack {
                Text("Parabéns,")
                    .font(projectFont(style: .extraBold, size: 40))
                    .foregroundColor(Color.fontColor)
                    .padding(.top, -80)
                ZStack {
                    Image("winners-background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 80)
                    HStack {
                        WinnersRibbon(winner: "Barreto", image: "cachorro-caramelo", place: .secondPlace, votes: "3")
                            .padding(.top, 80)
                        WinnersRibbon(winner: "Laula", image: "cachorro-caramelo", place: .firstPlace, votes: "3")
                            .padding(.top, -40)
                        WinnersRibbon(winner: "Mavi", image: "cachorro-caramelo", place: .thirdPlace, votes: "3")
                            .padding(.top, 80)

                    }
                 
                }
            }
        }
    }

}

