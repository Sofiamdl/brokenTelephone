//
//  ImageOrPhraseShown.swift
//  client
//
//  Created by sml on 02/04/23.
//

import SwiftUI

struct ImagePhraseShown: View {
    let isImage: Bool
    let info: String
    @State var isChosen: Bool
    
    var body: some View {
        HStack {
            isImage ? AnyView(Image(info)) : AnyView(Text(info))
            Button(action: {
                isChosen = !isChosen
            }) {
                SFSymbol(name: isChosen ? "hand.thumbsup.fill" : "hand.thumbsup", color: isChosen ? Color.projectOrange : Color.black, size: 30, weight: .light)
            }
        }
        .background(Color.projectWhite)
        .shadow(radius: 6)
    }

}
