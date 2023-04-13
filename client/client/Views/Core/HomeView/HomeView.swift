//
//  ContentView.swift
//  client
//
//  Created by sml on 28/03/23.
//  
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var coordinator: Coordinator
    @FocusState private var focusedField: Field?
    @EnvironmentObject private var socket: SocketViewModel
    
    var field = 0
    
    
    
    var body: some View {
        
        
        Image("HomeScreenBackground")
            .resizable()
            .ignoresSafeArea()
            .overlay(
                HStack{
                    HStack(){
                        //
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 30){
                        Image("projectTitle")
                            .resizable()
                            .frame(width: 459, height: 238)
                        
                        
                        VStack(alignment: .center, spacing: 8){
                            Text("Pronto para jogar?")
                                .font(projectFont(style: .extraBold, size: 40))
                                .foregroundColor(.fontColor)
                            Text("Crie sua sala e compartilhe o código com amigos")
                                .lineLimit(3)
                                .font(projectFont(style: .light, size: 24))
                                .foregroundColor(.fontColor)
                            
                            OrangeButton(buttonLabel: "Criar sala", buttonAction: {
                                socket.socket.emit("create_room", "")
                                socket.isHost = true
                                coordinator.goTo(view: .availableUsers)
                            })
                            .frame(alignment: Alignment.center)
                            
                        }
                        .frame(width: 400, alignment: .center)
                        
                        VStack(alignment: .center, spacing: 32){
                            Text("Já tenho um código")
                            
                                .font(projectFont(style: .extraBold, size: 40))
                                .foregroundColor(.fontColor)
                            
                            HStack(alignment: .center, spacing: 36){
                                
                                ForEach((0...3), id: \.self) { field in
                                    
                                    viewModel.roomCodeArray[field]
                                    
                                        .frame(alignment: Alignment.center)
                                    
                                        .focused($focusedField, equals: viewModel.fieldArray[field])
                                        .onSubmit {
                                            print("entrou aq")
                                            
                                            if viewModel.isFieldValid(field: viewModel.roomCodeArray[field]) {
                                                print(viewModel.roomCodeArray[field].textBindingManager.text)
                                                if focusedField != viewModel.fieldArray[3] {
                                                    focusedField = viewModel.fieldArray[field + 1]
                                                }
                                            }
                                            
                                        }
                                    
                                        .onChange(of: viewModel.roomCodeArray[field].textBindingManager.text) { newValue in
                                            if newValue != ""{
                                                print("sou diferente de nd")
                                                
                                                //                                            if viewModel.isFieldValid(field: viewModel.roomCodeArray[field]) {
                                                print("entrou aq")
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
                                if areFieldsValid {
                                    socket.socket.emit("join_room", finalCode)
                                } else {
                                    viewModel.showingAlert = true
                                    
                                }
                                
                                
                                
                            })
                            .frame(alignment: Alignment.center)
                            
                            
                            
                            
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
            .KeyboardAwarePadding(background: Color.gameRoomBackground)
            .onChange(of: socket.joinedRoom, perform: { joinedRoom in
                if joinedRoom == true {
                    socket.gameRoom = viewModel.returnFinalCode()
                    coordinator.goTo(view: .availableUsers)
                }
            })
        
    }
    
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
