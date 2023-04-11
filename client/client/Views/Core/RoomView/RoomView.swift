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
    @EnvironmentObject var viewModel: RoomViewModel
    @EnvironmentObject var socket: SocketViewModel
    let WIDTH: CGFloat = 936.0
    let HEIGHT: CGFloat = 588.0
    let column = [GridItem(.flexible())]
    
    @State var finished: Bool = false
    
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
                                    Text("\(socket.gameRoom)")
                                        .font(projectFont(style: .extraBold, size: 20))
                                }
                                    .frame(width: 300)
                            )
                        
                        Rectangle()
                            .foregroundColor(.loadingRoomBackground)
                            .frame(height: 424)
                            .overlay(
                                LazyVGrid(columns: column) {
                                    ForEach(socket.users, id: \.self) { user in
                                        HStack(spacing: 30){
                                            Image("zeca-pholder")
                                                .resizable()
                                                .frame(width: 64, height: 64)
                                                .cornerRadius(100)
                                            Text(user)
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
                    VStack(alignment: .leading, spacing: 20) {
                        TimerBar(orangeBarWidth: $viewModel.timerBarWidthOrange, yellowBarWidth: $viewModel.timerBarWidthYellow)
                            .onReceive(viewModel.timer) { _ in
                                print("aq", viewModel.gameStatus)
                                if viewModel.gameStatus != .userIsWaiting {
                                    viewModel.timeSubtraction()
                                }
                                if finished {
                                    viewModel.changeGameStatusToDrawing()
                                    finished = false
                                }
                            }
                        
                        switch viewModel.gameStatus {
                        case .userIsWaiting :
                            if (socket.isHost) {
                                Button("Começar", action: {
                                    socket.socket.emit("play", socket.gameRoom)
                                })
                            } else {
                                Text("Esperando o Host começar a partida...")
                            }
                        case .userIsDrawing:
                            canva
                                .overlay(
                                    VStack(alignment: .leading){
                                        Image("Rectangle 11")
                                            .overlay(
                                                Text(socket.currentPhrase)
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
                            Image(uiImage: UIImage(data: socket.currentImage) ?? UIImage() )
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
                    .onChange(of: viewModel.timeRemaining, perform: {
                        _ in
                        if viewModel.timerWentZero() {
                            if socket.isHost {
                                socket.socket.emit("host-timeout", "")
                            }
                        }
                    })
            )
            .onChange(of: socket.timeStarted, perform: { timeStarted in
                if timeStarted == true {
                    finished = true
                }
            }
            )
            .onChange(of: socket.timeout, perform: {timeout in
                if timeout == true {
                    if viewModel.gameStatus == .userIsDrawing {
                        sendCanvas()
                    } else if viewModel.gameStatus == .userIsGuessing {
                        socket.socket.emit("game", viewModel.userGuess)
                        viewModel.userGuess = ""
                    }
                    viewModel.gameModeChange()
                    socket.timeout = false
                    
                }
            })
        
    }
    
}

extension RoomView {
    var canva: some View {
        Canvas{
            context, size in
            for line in viewModel.lines {
                var path = Path()
                path.addLines(line.points)
                context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                
            }
            
        }
        .frame (width: WIDTH, height: HEIGHT)
        
        
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
    }
    
    func sendCanvas() {
        
        let renderer = ImageRenderer(content: canva.frame(width: WIDTH, height: HEIGHT))
        
        if let uiImage = renderer.uiImage {
            if let data = uiImage.pngData() {
                let strBase64 = data.base64EncodedString(options: .lineLength64Characters)
                socket.socket.emit("game", strBase64)
                viewModel.lines = []
            }
        }
    }
}

struct RoomViewContent_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
    }
}
