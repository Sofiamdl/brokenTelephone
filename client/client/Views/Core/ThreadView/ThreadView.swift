//
//  ThreadView.swift
//  client
//
//  Created by matheusvb on 03/04/23.
//

import SwiftUI

struct ThreadView: View {
    @ObservedObject private var viewModel = ThreadViewModel()
    
    var body: some View {
        ZStack {
            PageBackground(backFunction: viewModel.teste, nextFunction: viewModel.teste)
            HStack{
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.threads, id: \.self) {thread in
                            ForEach(thread.gameObjects, id: \.self) { gameObject in
                                ImagePhraseShown(isImage: gameObject.isImage, info: gameObject.isImage == true ? "desenho-teste" : "jacare", isChosen: false)
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct ThreadView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThreadView()
//    }
//}
