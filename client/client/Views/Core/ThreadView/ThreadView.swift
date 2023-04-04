//
//  ThreadView.swift
//  client
//
//  Created by matheusvb on 03/04/23.
//

import SwiftUI

struct ThreadViewObject: Identifiable {
    let id = UUID().uuidString
    let object: ImagePhraseShown
}

struct ThreadView: View {
    @ObservedObject private var viewModel = ThreadViewModel()
    
    var body: some View {
        ZStack {
            PageBackground(backFunction: viewModel.teste, nextFunction: viewModel.teste)
            HStack{
                Group {
                    ScrollView {
                        ZStack {
                            VStack {
                                ForEach(viewModel.threads, id: \.self) {_ in
                                    Image("green-square")
                                    Image("yellow-square")
                                }
                            }
                            .offset(y: 80)
                            VStack (alignment: .leading) {
                                Text("Vote no melhor momento")
                                    .font(projectFont(style: .extraBold, size: 30))
                                    .foregroundColor(Color.fontColor)
                                ForEach(viewModel.threads, id: \.self) {thread in
                                    ForEach(thread.gameObjects) { gameObject in
                                        ImagePhraseShown(isImage: gameObject.isImage, info: gameObject.isImage == true ? "desenho-teste" : "jacare", isChosen: false)
                                            .offset(x: gameObject.isImage == true ? 0 : 0)
                                    }
                                }
                            }
                            .offset(y: -200)
                        }
                    }
                }
                Group {
                    TabView {
                        Image("desenho-teste")
                        Image("desenho-teste")
                        Image("desenho-teste")
                    }.tabViewStyle(PageTabViewStyle())
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
