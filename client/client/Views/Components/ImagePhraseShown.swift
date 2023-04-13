//
//  ImageOrPhraseShown.swift
//  client
//
//  Created by sml on 02/04/23.
//

import SwiftUI

struct ImagePhraseShown: View, Identifiable {
    let id = UUID().uuidString
    let isImage: Bool
    let info: String
    @State var isChosen: Bool

    init(isImage: Bool, info: String, isChosen: Bool) {
        self.isImage = isImage
        self.info = info
        self.isChosen = isChosen
        print("print aqui:", info)
    }
    var body: some View {
        isImage ?
        AnyView(ZStack {
            Image(uiImage: UIImage(data: Data(base64Encoded: info, options: .ignoreUnknownCharacters)!) ?? UIImage())
                .resizable()
            
                .aspectRatio(contentMode: .fit)
            VStack (alignment: .trailing){
                Spacer()
                HStack (alignment: .bottom) {
                    Spacer()
                    Button(action: {
                        isChosen = !isChosen
                    }) {
                        SFSymbol(name: isChosen ? "hand.thumbsup.fill" : "hand.thumbsup", color: isChosen ? Color.projectOrange : Color.black, size: 30, weight: .light)
                    }
                }
            }
           
        }
            .aspectRatio(336/190, contentMode: .fit)
            .frame(width: 300)
            .padding(6)
            .background(Color.projectWhite)
        )
        :
        AnyView(HStack (alignment: .bottom) {
              Text(info)
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
                .font(projectFont(style: .extraBold, size: 15))
                .foregroundColor(Color.black)
                .fixedSize(horizontal: false, vertical: true)
            Button(action: {
                isChosen = !isChosen
            }) {
                SFSymbol(name: isChosen ? "hand.thumbsup.fill" : "hand.thumbsup", color: isChosen ? Color.projectOrange : Color.black, size: 30, weight: .light)
            }

        }
        .padding(4)
        .background(Color.projectWhite)
        .shadow(radius: 6)
        )
    }

}
