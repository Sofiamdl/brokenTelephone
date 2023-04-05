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
    
    

    
    let rows = GridItem()
    
    
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
                                        .font(projectFont(style: .extraBold, size: 30))
                                    Text("\(viewModel.gameRoomcode)")
                                        .font(projectFont(style: .extraBold, size: 30))


                                }
                                    .frame(width: 300)
                                    
                                                             

                            )
                        Rectangle()
                            .foregroundColor(.loadingRoomBackground)
                        Rectangle()
                            .foregroundColor(.projectWhite)
                        
                   
                    }
                    VStack(alignment: .leading, spacing: 20){
                        TimerBar(orangeBarWidth: $viewModel.timerBarWidthOrange, yellowBarWidth: $viewModel.timerBarWidthYellow)
                     
                            .onReceive(viewModel.timer) { _ in
                            if viewModel.timeRemaining > 0 {
                                viewModel.timerBarWidthOrange -= viewModel.timerBarDiminish
                                viewModel.timerBarWidthYellow += viewModel.timerBarDiminish
                                viewModel.timeRemaining -= 1
                                
                            }
                                
                                if viewModel.timerWentZero() {
                                    if viewModel.gameStatus == .userIsDrawing {
                                        viewModel.gameStatus = .userIsGuessing
                                    } else {
                                        viewModel.gameStatus = .userIsDrawing
                                    }
//                                    viewModel.timeRemaining = 300
//                                    viewModel.timerBarWidthYellow = 0.0
//                                    viewModel.timerBarWidthOrange = 942.0
                                }
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
                            VStack{
                                Text("Cachorro caramelo dando cambalhota")
                                    .font(projectFont(style: .extraBold, size: 30))
                                    .background(Color.fontColor)

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
                            Text("Aqui vai meu palpite")
                            Spacer()
                            
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
