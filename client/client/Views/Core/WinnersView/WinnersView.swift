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
            }
        }
    }

}

