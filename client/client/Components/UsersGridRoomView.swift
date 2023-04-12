//
//  File.swift
//  client
//
//  Created by mvitoriapereirac on 10/04/23.
//

import SwiftUI

struct UsersGridRoomView: View {
    let roomCode: String
    let column = [GridItem(.flexible())]
    @Binding var userName: [String]
    @Binding var height: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.loadingRoomBackground)
                .overlay(
                    HStack(alignment: .top){
                        LazyVGrid(columns: column) {
                            ForEach(0..<self.userName.count, id: \.self) { index in
                                HStack(spacing: 10){
                                    Image("zeca-pholder")
                                        .resizable()
                                        .frame(width: 64, height: 64)
                                        .cornerRadius(100)
                                    Text(self.userName[index])
                                        .frame(alignment: .leading)
                                        .font(projectFont(style: .extraBold, size: 15))
                                        .foregroundColor(Color.fontColor)
                                    Spacer()
                                }
                                .padding(.leading, 10)
                                
                                
                            }
                            
                            
                        }
                    }
                )
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.fontColor)
                    .frame(height: 92)
                    .overlay(
                        VStack(spacing: 5){
                            Text("Participantes")
                                .font(projectFont(style: .extraBold, size: 20))
                        }
                        
                    )
                Spacer()
                Rectangle()
                    .foregroundColor(.projectWhite)
                    .frame(height: 80)
                    .offset(y:-((height/10)+10))
                    .overlay (
                        Text("\(userName.count)/5 jogadores")
                            .font(projectFont(style: .extraBold, size: 15))
                            .foregroundColor(Color.black)
                            .offset(y:-((height/10)+10))

                    )

            }

        }
    }
}
