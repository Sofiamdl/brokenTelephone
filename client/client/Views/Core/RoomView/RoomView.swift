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
    @State var HEIGHT: CGFloat = 0
    @State var image_height: CGFloat = 0
    @State var changed: Bool = false

    let WIDTH: CGFloat = UIScreen.main.bounds.width * 0.7
    let column = [GridItem(.flexible())]

    
    var body: some View {
        GameRoomBackground(backFunction:{
            viewModel.reset()
            coordinator.gotoHomePage()
        } )
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Spacer(minLength: 50)
                    HStack (alignment: .top, spacing: 20){
                        UsersGridRoomView(roomCode: socket.gameRoom, userName: $socket.users, height: $image_height)
                            .padding(.leading, 20)
                            .offset(y: (image_height/10)+20)
                        VStack(alignment: .leading, spacing: 20) {
                            TimerBar(orangeBarWidth: $viewModel.timerBarWidthOrange, yellowBarWidth: $viewModel.timerBarWidthYellow, height: $image_height)
                                .onReceive(viewModel.timer) { _ in
                                    viewModel.timeSubtraction()
                                }.padding(.trailing, 20)
                            switch viewModel.gameStatus {
                            case .userIsDrawing:
                                ZStack {
                                    canva
                                    VStack(alignment: .leading){
                                        Image("Rectangle 11")
                                            .overlay(
                                                Text(socket.currentPhrase)
                                                    .font(projectFont(style: .extraBold, size: 20))
                                            )
                                    }
                                    .frame(height: HEIGHT, alignment: .top)
                                }
                                ColorPickerView(selectedColor: $viewModel.selectedColor, width: $HEIGHT)
                                    .onChange(of: viewModel.selectedColor) {
                                        newColor in
                                        viewModel.currentLine.color =  newColor
                                    }
                                
                                
                            case .userIsGuessing:
                                Image(uiImage: UIImage(data: socket.currentImage) ?? UIImage())
                                    .resizable()
                                    .frame(width: WIDTH, height: image_height)
                                
                                TextField("palpite", text: $viewModel.userGuess, prompt: Text("Digite seu palpite"))
                                    .font(projectFont(style: .extraBold, size: 20))
                                    .frame(width: WIDTH-48)
                                    .shadow(radius: 5)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, image_height/15)
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
                }
            )
            .KeyboardAwarePadding(background: Color.gameRoomBackground)
        
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
            }).onChange(of: socket.gameIsOver) { newValue in
                if newValue == true {
                    coordinator.goTo(view: .threadsView)
                    coordinator.popView(view: .gameRoom)
                }
            }
        
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
        .aspectRatio(CGSize(width: 936.0, height: 588.0), contentMode: .fit)
        .frame (width: WIDTH)
        .background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear{
                        HEIGHT = proxy.size.height
                        viewModel.timerBarWidthOrange = self.WIDTH
                        viewModel.timerBarWidth = self.WIDTH
                        viewModel.changeTimeBarDiminish()
                        if !changed {
                            image_height = HEIGHT
                            changed = true
                        }
                    }
            }
        )
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
