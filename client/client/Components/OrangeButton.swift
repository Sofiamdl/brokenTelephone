//
//  OrangeButton.swift
//  client
//
//  Created by mvitoriapereirac on 29/03/23.
//

import SwiftUI

struct OrangeButton: View {
    var buttonLabel: String = ""
    var buttonAction: () -> Void
    
    var body: some View {
        ZStack{
            Button(action:  {
                buttonAction()
            }){
                Text(self.buttonLabel)
                    .font(projectFont(style: .extraBold, size: 24))
                    .foregroundColor(.white)
                    .padding(.all, 10)
                    .frame(width: 344, height: 69)


                    .background(RoundedRectangle(cornerRadius: 20.0).fill(Color.projectOrange))

            }
            
            
        }
        
    }
    
    
    
}
//struct ButtonContent_Previews: PreviewProvider {
//    static var previews: some View {
////        OrangeButton()
//    }
//}
