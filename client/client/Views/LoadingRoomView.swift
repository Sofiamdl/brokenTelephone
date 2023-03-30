//
//  LoadingRoomView.swift
//  client
//
//  Created by mvitoriapereirac on 29/03/23.
//

import SwiftUI

struct LoadingRoomView: View {
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        Color.loadingRoomBackground
            .ignoresSafeArea()
            .overlay(
                VStack (alignment: .center, spacing: 40){
                    Text("Carregando...")
                        .font(projectFont(style: .extraBold, size: 60))
                        .foregroundColor(Color.fontColor)
                    Text("Você sabia? As havaianas são insipiradas nas sandálias japonesas Zori, feitas de madeira lascada e palha de arroz com tiras de tecido, muito utilizadas por agricultores.")
                        .font(projectFont(style: .extraBold, size: 30))
                        .foregroundColor(Color.fontColor)
                    Spacer()
                    HStack{
                        Image("havaianas-pholder")
                            .resizable()
                            .frame(width: 30, height: 40)
                        Image("havaianas-pholder")
                            .resizable()
                            .frame(width: 30, height: 40)
                        Image("havaianas-pholder")
                            .resizable()
                            .frame(width: 30, height: 40)
                        Image("havaianas-pholder")
                            .resizable()
                            .frame(width: 30, height: 40)
                    }
                    Spacer()


                }
                    .padding(130)
            )
        
    }
}
struct LoadingRoomContent_Previews: PreviewProvider {
    static var previews: some View {
        LoadingRoomView()
    }
}
