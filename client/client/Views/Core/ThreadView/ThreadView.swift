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
    @EnvironmentObject var socket: SocketViewModel

    var body: some View {
        ZStack {
            PageBackground(backFunction: viewModel.teste, nextFunction: viewModel.teste)
            HStack {
                Group {
                    ScrollView {
                        ZStack {
                            VStack {
                                ForEach(viewModel.threads, id: \.self) {_ in
                                    Image("green-square")
                                    Image("yellow-square")
                                }
                            }
                            .offset(y: 180)
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
                            .offset(y: -100)
                        }
                    }.frame(minWidth: 0, maxWidth: .infinity)
                }
                Group {
                    VStack(alignment: .center) {
                        Text("[placeholder: frase relativa ao personagem]")
                            .font(projectFont(style: .extraBold, size: 30))
                            .foregroundColor(Color.fontColor)
                            .offset(y: 128)
                        TabView {
                            VStack {
                                Text("Animal típico da região do pantanal")
                                    .font(projectFont(style: .light, size: 30))
                                    .foregroundColor(Color.fontColor)
                                GifAnimationView(imageName: "C", imageLastIndex: 4, frameSize: CGSize(width: 400, height: 400))
                                    
                                
                            }
                            
                            VStack {
                                Text("Planta típica da região norte")
                                    .font(projectFont(style: .light, size: 30))
                                    .foregroundColor(Color.fontColor)
                                MoveAnimation()
                               
                            }
                            
                            VStack {
                                Text("Arara")
                                    .font(projectFont(style: .light, size: 30))
                                    .foregroundColor(Color.fontColor)
                                GifAnimationView(imageName: "A", imageLastIndex: 5,  frameSize: CGSize(width: 400, height: 400))                            }
                            VStack {
                                Text("Cuscuz")
                                    .font(projectFont(style: .extraBold, size: 40))
                                    .foregroundColor(Color.fontColor)
                                GifAnimationView(imageName: "CZ", imageLastIndex: 2,  frameSize: CGSize(width: 400, height: 400))                            }

                            VStack {
                                Text("Pandeiro")
                                    .font(projectFont(style: .extraBold, size: 40))
                                    .foregroundColor(Color.fontColor)
                                GifAnimationView(imageName: "P", imageLastIndex: 2,  frameSize: CGSize(width: 400, height: 400))                            }
                        }.tabViewStyle(PageTabViewStyle())
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    Button("GET THREADS") {
                        Task {
                            let user = socket.users[0]
                            let threads = await viewModel.returnThreads(user: user)
                            print(threads)
                        }
                    }
                }
            }
        }
    }
}

struct ThreadView_Previews: PreviewProvider {
    static var previews: some View {
        ThreadView()
    }
}
