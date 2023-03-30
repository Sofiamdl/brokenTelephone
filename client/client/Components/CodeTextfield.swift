//
//  CodeTextfield.swift
//  client
//
//  Created by mvitoriapereirac on 29/03/23.
//

import SwiftUI

struct RoomCodeTextfield: View {
    @State var roomCode: String = ""
   
   
    var body: some View {
            
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(.projectGray)
                .frame(width: 58, height: 58, alignment: .center)

    //                                            .frame(width: 58, height: 58, alignment: .center)
                .overlay(
                    TextField("codigo", text: $roomCode, prompt: Text("a") )
                            .font(projectFont(style: .extraBold, size: 24 ))
                            .frame(width: 58, height: 58, alignment: .center)
    //                        .padding(.all, -20)

                )
        }
        
//            .frame(width: 58, height: 58, alignment: .center)

        
    
    
    
}

struct TxtfieldContent_Previews: PreviewProvider {
    static var previews: some View {
        RoomCodeTextfield()
    }
}
