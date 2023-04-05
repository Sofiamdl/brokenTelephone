//
//  PageBackground.swift
//  client
//
//  Created by sml on 02/04/23.
//

import SwiftUI

struct PageBackground: View {
    let backFunction: () -> Void
    let nextFunction: () -> Void

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
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Button(action: {
                        nextFunction()
                    }) {
                        Image("right-bottom")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                    }
                }
            }
        }.ignoresSafeArea()
            .background(Color.gameScreenBackground)
    }

}

