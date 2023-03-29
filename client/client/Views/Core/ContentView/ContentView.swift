//
//  ContentView.swift
//  client
//
//  Created by sml on 28/03/23.
//  
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var viewModel = ContentViewModel()
       
    var body: some View {
        Text(viewModel.example ?? "Hello World")
    }

}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}