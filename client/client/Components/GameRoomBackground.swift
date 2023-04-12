//
//  PageBackground.swift
//  client
//
//  Created by sml on 02/04/23.
//

import SwiftUI

struct GameRoomBackground: View {
    let backFunction: () -> Void

    var body: some View {
        VStack{
            HStack {
                VStack(alignment: .leading) {
                    Button(action: {
                        backFunction()
                    }) {
                        Image("left-top")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250)

                    }
                }
                Spacer()
            }
            Spacer()
        }.ignoresSafeArea()
            .background(Color.gameScreenBackground)
    }

}

