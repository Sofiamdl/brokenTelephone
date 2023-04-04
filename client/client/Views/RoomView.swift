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
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var selectedColor: Color = Color.red
    
    let rows = GridItem()
    
    
    var body: some View {
        Color.gameRoomBackground
            .ignoresSafeArea()
            .overlay(
                HStack{
                    VStack(spacing: 0){
                                
                                    Rectangle()
                                        .foregroundColor(.fontColor)
                                    Rectangle()
                                        .foregroundColor(.loadingRoomBackground)
                                    Rectangle()
                                        .foregroundColor(.projectWhite)
                                
                                
                                
                
                
                            }
                    VStack(alignment: .leading){
                                Rectangle()
                                    .fill(Color.fontColor)
                                    .frame(width: 942, height: 58)
                                    .overlay(
                                    Rectangle()
                                        .fill(Color.projectOrange)
                                        .frame(width: 25, alignment: .leading)
                                    )
                
                                Canvas{
                                    context, size in
                                    for line in lines {
                                        var path = Path()
                                        path.addLines(line.points)
                                        context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
//                                        path.addSize(width: 936, height: 588)
                                    }
                                    

                                    
                                }
                                .frame (width: 936, height: 588)

                                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                    .onChanged({
                                    value in let newPoint = value.location
                                        currentLine.points.append(newPoint)
                                        self.lines.append(currentLine)
                                })
                                        .onEnded({ value in
                                            self.currentLine = Line(points: [], color: selectedColor)
                                        })
                                )
                                .background(Color.white)
                        
                        ColorPickerView(selectedColor: $selectedColor)
                            .onChange(of: selectedColor) {
                                newColor in
                                currentLine.color =  newColor
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
