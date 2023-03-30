//
//  ContentView.swift
//  client
//
//  Created by sml on 28/03/23.
//  
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        Color.homePageBackground
            .ignoresSafeArea()
            .overlay(
                HStack{
                    HStack(){
                        Image("zeca-pholder")
                        .resizable()
                            .frame(width: 500, height: 600)
                            
                    }
                       
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 80){
                        Text("NOME")
                        .font(projectFont(style: .extraBold, size: 100))
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text("Pronto para jogar?")
                            .font(projectFont(style: .extraBold, size: 40))
                            .foregroundColor(.fontColor)
                            Text("Crie sua sala e compartilhe o código com amigos")
                            .font(projectFont(style: .light, size: 24))
                            .foregroundColor(.fontColor)
                            
                            OrangeButton(buttonLabel: "Criar sala")
                            
                        }
                        .frame(width: 400, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 32){
                            Text("Já tenho um código")
                                .font(projectFont(style: .extraBold, size: 40))
                                .foregroundColor(.fontColor)
                            HStack(spacing:36){
                                
                                        ForEach((0...3), id: \.self) { field in

                                            RoomCodeTextfield()

                                    }
                                        .frame(width: 58, height: 58, alignment: .center)

                                }
                            
                            OrangeButton(buttonLabel: "Entrar")
                            
                            Spacer()
                        }
                        .frame(width: 400, alignment: .center)
                        
                        
                        
                        
                    
                    
                    
                    }
                    
                        
                }
                    .padding(15)
            )
        
        
        
        
    }

}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
