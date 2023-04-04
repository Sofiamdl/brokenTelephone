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
                    HStack {
                        WinnersRibbon(winner: "Alguém", image: "cachorro-caramelo", place: .secondPlace, votes: "3")
                            .padding(.top, 100)
                        WinnersRibbon(winner: "Alguém", image: "cachorro-caramelo", place: .firstPlace, votes: "3")
                            .padding(.top, -40)
                        WinnersRibbon(winner: "Alguém", image: "cachorro-caramelo", place: .thirdPlace, votes: "3")
                            .padding(.top, 100)

                    }
                 
                }
            }
        }
    }

}

