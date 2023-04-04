//
//  ColorPicker.swift
//  client
//
//  Created by mvitoriapereirac on 04/04/23.
//

import Foundation
import SwiftUI

struct ColorPickerView: View {
    
    let colors = [Color.red, Color.orange, Color.black, Color.green, Color.yellow, Color.blue]
    @Binding var selectedColor: Color
    var indice = 0
    
    var body: some View {
        
        VStack{
            HStack{
                ForEach((0...2), id: \.self) { indice in
//                    CircleColorPicker(color: colors[indice])
                    Circle()
                        .foregroundColor(colors[indice])
                        .onTapGesture {
                            selectedColor = colors[indice]
                        }
                        .overlay (
                            Circle()
                                .strokeBorder( colors[indice] == selectedColor ? Color.black : Color.clear)
                        )
                   
                        
                    }
                        
                    
                }
            }
            HStack{
                ForEach((3...5), id: \.self) { indice in
                    Circle()
                        .foregroundColor(colors[indice])
                        .onTapGesture {
                            selectedColor = colors[indice]
                        }
                        .overlay (
                            Circle()
                                .strokeBorder( colors[indice] == selectedColor ? Color.black : Color.clear)
                        )
                }
                
            }
        }
    
    
}
