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
    
    func returnThreads(user: String) async -> [ThreadResponse] {
        var _threads: [ThreadResponse] = []
        let semaphore = DispatchSemaphore(value: 0)
        
        getThreadFromUser(user: user) { response in
            if let response = response {
                _threads = response
                semaphore.signal()
            } else {
                _threads = []
                semaphore.signal()
            }
        }
        
        semaphore.wait()
        return _threads
    }
    
    func getThreadFromUser(user: String, completion: @escaping ([ThreadResponse]?) -> ()) {
        let urlString = "https://6624-150-161-70-2.ngrok-free.app/thread/\(user)"
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data return")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let threadsResponse = try decoder.decode(RawThread.self, from: data)
                completion(threadsResponse.data)
                return

            } catch  {
                print(error)
                completion(nil)
            }
        }
        
        task.resume()
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
