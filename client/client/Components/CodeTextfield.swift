//
//  CodeTextfield.swift
//  client
//
//  Created by mvitoriapereirac on 29/03/23.
//

import SwiftUI

struct RoomCodeTextfield: View {
    
    
    @ObservedObject var textBindingManager = TextBindingManager(limit: 1)
    
    
   
    
    var body: some View {
            
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(.projectGray)
                .frame(width: 58, height: 58, alignment: .center)
                .overlay(
                    TextField("codigo", text: $textBindingManager.text, prompt: Text("") )
                            .font(projectFont(style: .extraBold, size: 24 ))
                            .frame(width: 20, height: 58, alignment: .center)
                        

                )
        }
        
  
    
    
}

class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count == characterLimit {
                text = oldValue
                
            }
        }
        
        
    }
    let characterLimit: Int

    init(limit: Int = 5){
        characterLimit = limit
    }
}

struct TxtfieldContent_Previews: PreviewProvider {
    static var previews: some View {
        RoomCodeTextfield()
    }
}
