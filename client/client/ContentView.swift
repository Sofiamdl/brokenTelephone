//
//  ContentView.swift
//  client
//
//  Created by sml on 20/03/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .font(projectFont(style: .light, size: 30))
                .foregroundColor(Color("ProjectRed"))
        }
        .padding()
        
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
