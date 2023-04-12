//
//  LoadingRoomView.swift
//  client
//
//  Created by mvitoriapereirac on 29/03/23.
//

import SwiftUI

struct LoadingRoomView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State var timerMax = 2
    @State var navigationBarBackButtonHidden = true

    
    
    var body: some View {
//        ZStack {
         
            VStack (alignment: .center){
                Text("Carregando...")
                    .font(projectFont(style: .extraBold, size: 60))
                    .foregroundColor(Color.fontColor)
                Text("Você sabia? As havaianas são insipiradas nas sandálias japonesas Zori, feitas de madeira lascada e palha de arroz com tiras de tecido, muito utilizadas por agricultores.")
                    .font(projectFont(style: .extraBold, size: 30))
                    .multilineTextAlignment(TextAlignment.center)
                    .foregroundColor(Color.fontColor)
                Spacer()
                HStack(spacing: 0){
                    GifAnimationView(imageName: "STEP", imageLastIndex: 3, frameSize: CGSize(width: 1284, height: 311))
                   
                    
//
                   

                   

                    
                }
                
                
                Spacer()
                
                
            }
            .padding(130)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.loadingRoomBackground)

        
        
    }
        
}
struct LoadingRoomContent_Previews: PreviewProvider {
    static var previews: some View {
        LoadingRoomView()
    }
}
