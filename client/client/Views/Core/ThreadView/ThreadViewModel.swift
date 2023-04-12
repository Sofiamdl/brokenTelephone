//
//  ThreadViewModel.swift
//  client
//
//  Created by matheusvb on 03/04/23.
//

import SwiftUI

struct GameObject: Hashable, Identifiable {
    let id = UUID().uuidString
    var isImage: Bool
    var data: String
}



final class ThreadViewModel: ObservableObject {
    @Published var threads: [Thread] = [
        Thread(gameObjects: [
            GameObject(isImage: false, data: ""),
            GameObject(isImage: true, data: ""),
            GameObject(isImage: false, data: ""),
            GameObject(isImage: true, data: ""),
        ])
    ]
    
    @Published var objectCount: Int = 0
    
    init() {
        let pngData = UIImage(named: "desenho-teste")?.pngData()
        let strBase64 = pngData?.base64EncodedString(options: .lineLength64Characters)
        
        for singleThread in threads {
            for var gameObject in singleThread.gameObjects {
                if gameObject.isImage {
                    gameObject.data = strBase64 ?? ""
                }
                objectCount += 1
            }
        }
    }
        
    func teste() {
        print("back-next")
    }
    
    func getSquareAmount() -> Int {
        return objectCount % 4
    }
    
    func getThread() {
        
    }
}

var teste: [Thread] = [
    Thread(gameObjects: [
        GameObject(isImage: false, data: ""),
        GameObject(isImage: true, data: ""),
        GameObject(isImage: false, data: ""),
        GameObject(isImage: true, data: ""),
    ])
]
