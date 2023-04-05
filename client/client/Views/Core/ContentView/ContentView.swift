//
//  ContentView.swift
//  client
//
//  Created by sml on 28/03/23.
//  
//

import SwiftUI
import Combine

struct ContentView: View {

    @ObservedObject private var viewModel = ContentViewModel()
    @EnvironmentObject private var coordinator: Coordinator
    @FocusState private var focusedField: Field?
    
    
    var field = 0
    
    

    

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
                                
                                OrangeButton(buttonLabel: "Criar sala", buttonAction: {
                                    coordinator.goToLoadingPage()
                                })
                                
                            }
                            .frame(width: 400, alignment: .center)
                            
                            VStack(alignment: .leading, spacing: 32){
                                Text("Já tenho um código")
                                    .font(projectFont(style: .extraBold, size: 40))
                                    .foregroundColor(.fontColor)
                                
                                HStack(spacing: 36){
                                    
                                    ForEach((0...3), id: \.self) { field in
                                        
                                        viewModel.roomCodeArray[field]
                                            .focused($focusedField, equals: viewModel.fieldArray[field])
                                            .onSubmit {
                                                if viewModel.isFieldValid(field: viewModel.roomCodeArray[field]) {
                                                    if focusedField != viewModel.fieldArray[3] {
                                                        focusedField = viewModel.fieldArray[field + 1]
                                                    }
                                                }
                                                
                                               
                                                
                                                
                                            }
                                        
                                        
                                    }
                                    .frame(width: 58, height: 58, alignment: .center)
                                    
                                    
                                }
                                
                                
                                OrangeButton(buttonLabel: "Entrar", buttonAction: {
                                    let finalCode = viewModel.returnFinalCode()
                                    let areFieldsValid = viewModel.areFieldsValid()
                                    print(finalCode)
                                    if areFieldsValid {
                                        coordinator.goToLoadingPage()
                                        print("oi")
                                    } else {
                                        viewModel.showingAlert = true
                                        
                                    }
                                    
                                    
                                    
                                })
                                
                                Spacer()
                                Spacer()
                                
                            }
                            .frame(width: 400, alignment: .center)
                            .alert("Por favor, preencha corretamente os campos com o código da sua sala!", isPresented: $viewModel.showingAlert) {
                                Button("OK", role: .cancel) {
                                    viewModel.showingAlert = false
                                }
                            }
                            
                        }
                        
                    }
                        .padding(15)
                        .onTapGesture {
                            
                        }
                )

            
        

    }

}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
