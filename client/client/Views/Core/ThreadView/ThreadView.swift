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
                        ForEach(0..<100) {
                            Text("Row \($0)")
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
