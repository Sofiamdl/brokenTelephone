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
    @State var threads: [ThreadResponse] = []
    
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
                                ForEach(threads, id: \.self) {thread in
                                    ImagePhraseShown(isImage: thread.type == "drawing", info: thread.data, isChosen: false)
                                            .offset(x: thread.type == "drawing" ? 0 : 0)
                                }
                            }
                            .offset(y: -100)
                        }
                    }.frame(minWidth: 0, maxWidth: .infinity)
                }
                Group {
                    VStack(alignment: .center) {
                        Text("O personagem era:")
                            .font(projectFont(style: .extraBold, size: 30))
                            .foregroundColor(Color.fontColor)
                            .offset(y: 128)
                        TabView {
                            VStack {
                                Text("Mula sem cabeça")
                                    .font(projectFont(style: .extraBold, size: 40))
                                    .foregroundColor(Color.fontColor)
                                Image("desenho-teste")
                            }
                            VStack {
                                Text("Mula sem cabeça")
                                    .font(projectFont(style: .extraBold, size: 40))
                                    .foregroundColor(Color.fontColor)
                                Image("desenho-teste")
                            }
                            VStack {
                                Text("Mula sem cabeça")
                                    .font(projectFont(style: .extraBold, size: 40))
                                    .foregroundColor(Color.fontColor)
                                Image("desenho-teste")
                            }
                        }.tabViewStyle(PageTabViewStyle())
                    }.frame(minWidth: 0, maxWidth: .infinity)
                   
                }
            }
        }.onAppear {
                Task {
                    let user = socket.users[viewModel.userIndex]
                    threads = await viewModel.returnThreads(user: user)
                }
            
        }
    }
}

//struct ThreadView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThreadView()
//    }
//}
