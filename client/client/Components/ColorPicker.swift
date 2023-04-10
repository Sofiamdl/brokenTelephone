//
//  ColorPicker.swift
//  client
//
//  Created by mvitoriapereirac on 04/04/23.
//

import Foundation
import SwiftUI

struct ColorPickerView: View {
    
    let colors = [Color.yellow, Color.projectOrange, Color.projectRed, Color.purple, Color.cyan, Color.blue]
    @Binding var selectedColor: Color
    
    var body: some View {
        
        VStack{
            HStack{
                ForEach((0...2), id: \.self) { indice in
                    Circle()
                        .frame(width: 30, height: 30)
                    
                        .foregroundColor(colors[indice])
                        .onTapGesture {
                            selectedColor = colors[indice]
                        }
                        .overlay (
                            Circle()
                                .strokeBorder( colors[indice] == selectedColor ? Color.fontColor : Color.clear)
                            
                        )
                    
                    
                }
                
                
            }
            
            HStack{
                ForEach((3...5), id: \.self) { indice in
                    Circle()
                        .frame(width: 30, height: 30)
                    
                        .foregroundColor(colors[indice])
                        .onTapGesture {
                            selectedColor = colors[indice]
                        }
                        .overlay (
                            Circle()
                                .strokeBorder( colors[indice] == selectedColor ? Color.fontColor : Color.clear)
                            
                            
                        )
                }
                
            }
        }
        
    }
}
