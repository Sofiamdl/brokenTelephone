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
                    }
                }
            }
        }.ignoresSafeArea()
            .background(Color.gameScreenBackground)
    }

}

