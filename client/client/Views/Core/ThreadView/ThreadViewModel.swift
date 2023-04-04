//
//  ThreadViewModel.swift
//  client
//
//  Created by matheusvb on 03/04/23.
//

import SwiftUI

struct GameObject {
    let type: String
    let data: String
}

struct Thread {
    let threads: [GameObject]
}

final class ThreadViewModel: ObservableObject {
    @Published var threads: [Thread] = []

    
    
    func teste() {
        print("back-next")
    }
}
