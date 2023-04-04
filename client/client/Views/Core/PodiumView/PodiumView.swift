//
//  PodiumView.swift
//  client
//
//  Created by sml on 02/04/23.
//

import SwiftUI

struct PodiumView: View {
    @ObservedObject private var viewModel = PodiumViewModel()

    var body: some View {
        ZStack {
            PageBackground(backFunction: viewModel.teste, nextFunction: viewModel.teste)
            VStack {
                Text("O melhor dos melhores")
                    .font(projectFont(style: .extraBold, size: 40))
                    .foregroundColor(Color.fontColor)
                Text("decida o grande vencedor")
                    .font(projectFont(style: .extraBold, size: 30))
                    .foregroundColor(Color.fontColor)

                ZStack {
                    Image("yellow-background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 1100)
                    HStack {
                        ImagePhraseShown(isImage: true, info: "desenho-teste", isChosen: false)
                        Spacer(minLength: 100)
                        ImagePhraseShown(isImage: false, info: "jacaré baterista", isChosen: false)
                    }.frame(width: 900)
                }
                ZStack  {
                    Image("green-background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 1100)
                    HStack {
                        ImagePhraseShown(isImage: false, info: "jacaré baterista jacaré bateristajacaré bateristajacaré baterista", isChosen: false)
                        Spacer(minLength: 100)
                        ImagePhraseShown(isImage: true, info: "desenho-teste", isChosen: false)
                    }.frame(width: 900)
                }                
            }
        }
    }

}
