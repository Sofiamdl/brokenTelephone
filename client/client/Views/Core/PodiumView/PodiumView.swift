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
                Text("Decida o grande vencedor")
                ImagePhraseShown(isImage: false, info: "Jacare pagodeiro", isChosen: false)
//                Image("yellow-background")
//                Image("green-background")
            }
        }
    }

}
