//
//  RoomView.swift
//  client
//
//  Created by mvitoriapereirac on 30/03/23.
//

import SwiftUI
import PencilKit

struct RoomView: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel = RoomViewModel()
    
    
    

    
    let column = [GridItem(.flexible())]

    
    var body: some View {
        Color.gameRoomBackground
            .ignoresSafeArea()
            .overlay(
                HStack{
                    VStack(spacing: 0){
                        
                        Rectangle()
                            .foregroundColor(.clear)
                        
                        Rectangle()
                            .foregroundColor(.fontColor)
                            .overlay(
                                VStack(spacing: 5){
                                    Text("Chama os amigos")
                                        .font(projectFont(style: .extraBold, size: 20))
                                    Text("\(viewModel.gameRoomcode)")
                                        .font(projectFont(style: .extraBold, size: 20))


                                }
                                    .frame(width: 300)
                                    
                                                             

                            )
                        
                        Rectangle()
                            .foregroundColor(.loadingRoomBackground)
                            .frame(height: 424)
                            .overlay(
                                LazyVGrid(columns: column) {
                                    ForEach((0...4), id: \.self) { _ in
                                        HStack(spacing: 30){
                                            
                                            Image("zeca-pholder")
                                                .resizable()
                                                .frame(width: 64, height: 64)
                                                .cornerRadius(100)
                                            Text("Usuário")
                                                .frame(alignment: .leading)
                                                .font(projectFont(style: .extraBold, size: 15))
                                                .foregroundColor(Color.fontColor)
                                            Spacer()
                                        }
                                        .padding(.leading, 10)
                                        
                                        
                                    }
                                }
                            )
                        Rectangle()
                            .foregroundColor(.projectWhite)
                        
                   
                    }
                    VStack(alignment: .leading, spacing: 20){
                        TimerBar(orangeBarWidth: $viewModel.timerBarWidthOrange, yellowBarWidth: $viewModel.timerBarWidthYellow)
                     
                            .onReceive(viewModel.timer) { _ in
                            viewModel.timeSubtraction()
                            viewModel.gameModeChange()
                        }
                        
                        switch viewModel.gameStatus {
                        case .userIsDrawing:
                     
                        Canvas{
                            context, size in
                            for line in viewModel.lines {
                                var path = Path()
                                path.addLines(line.points)
                                context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                                
                            }
                   
                        }
                        .frame (width: 936, height: 588)

                        
                        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged({
                                value in let newPoint = value.location
                                viewModel.currentLine.points.append(newPoint)
                                self.viewModel.lines.append(viewModel.currentLine)
                            })
                                .onEnded({ value in
                                    self.viewModel.currentLine = Line(points: [], color: viewModel.selectedColor)
                                })
                                    
                        )
                        .background(Color.white)

                        .overlay(
                            VStack(alignment: .leading){
                                Image("Rectangle 11")
                                    .overlay(
                                        Text("Cachorro caramelo dando cambalhota")
                                            .font(projectFont(style: .extraBold, size: 20))
                                        
                                    )
                                

                            }
                            .frame(height: 588, alignment: .top)
                            
                                                    )
                         
                                ColorPickerView(selectedColor: $viewModel.selectedColor)
                                    .onChange(of: viewModel.selectedColor) {
                                        newColor in
                                        viewModel.currentLine.color =  newColor
                                    }
                        
                        
                        case .userIsGuessing:
                            Image("zeca-pholder")
                                .resizable()
                                .frame (width: 936, height: 588)
                            
                            TextField("palpite", text: $viewModel.userGuess, prompt: Text("Digite seu palpite"))
                                .font(projectFont(style: .extraBold, size: 20))
                                .frame(width: 888)
                                .shadow(radius: 5)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 44)
                                .background(Color.white)
                            
                                    
                                   
                                    

                                


                            
                        }
                    }
                }
            )
        
        
    }
    
    
}
struct RoomViewContent_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
    }
}
