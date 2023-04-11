//
//  File.swift
//  client
//
//  Created by mvitoriapereirac on 10/04/23.
//

import SwiftUI

struct UsersGrid: View {
    let roomCode: String
    let column = [GridItem(.flexible())]
    @Binding var userName: [String]
    
    var body: some View {
        VStack(spacing: 0){
            
            Rectangle()
                .foregroundColor(.fontColor)
                .frame(height: 142)
            
                .overlay(
                    VStack(spacing: 5){
                        Text("Chama os amigos")
                            .font(projectFont(style: .extraBold, size: 20))
                        Text("\(roomCode)")
                            .font(projectFont(style: .extraBold, size: 20))
                        
                        
                    }
                    
                )
            
            Rectangle()
                .foregroundColor(.loadingRoomBackground)
                .overlay(
                    LazyVGrid(columns: column) {
                        ForEach(0..<self.userName.count, id: \.self) { index in
                            HStack(spacing: 30){
                                
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
                )
            Rectangle()
                .foregroundColor(.projectWhite)
                .frame(height: 80)
                .overlay (
                    Text("\(userName.count)/5 jogadores")
                        .font(projectFont(style: .extraBold, size: 15))
                        .foregroundColor(Color.black)
                )
            
            
        }
    }
}
