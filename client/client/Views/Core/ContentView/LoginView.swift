//
//  ContentView.swift
//  client
//
//  Created by sml on 20/03/23.
//

import SwiftUI
import AuthenticationServices

let postURL = "https://localhost:3001/auth"

class Network: ObservableObject {
    @Published var user: SentUser?
    
    func postData() {
        guard let url = URL(string: postURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do {
                
                if let data = data {
                    
                    let article = JSONDecoder()
                    let result = try article.decode(SentUser.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.user = result
                    }
                    
                } else {
                    print ("No data")
                }
                
            } catch (let error) {
                print (error.localizedDescription)
            }
            
        }.resume()
    }
}

struct SignInWithAppleSwiftUIButton: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
      if colorScheme.self == .dark {
          SignInButton(SignInWithAppleButton.Style.whiteOutline)
      }
      else {
          SignInButton(SignInWithAppleButton.Style.black)
      }
    }

    func SignInButton(_ type: SignInWithAppleButton.Style) -> some View{
        return SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
            let controller = ASAuthorizationController(authorizationRequests: [request])
            
        } onCompletion: { result in
            switch result {
            case .success(let authResults):
                print("Authorisation successful \(authResults)")

            case .failure(let error):
                print("Authorisation failed: \(error.localizedDescription)")
            }
            
        }
        .frame(width: 280, height: 60, alignment: .center)
        .signInWithAppleButtonStyle(type)
    }
}


struct LoginPage: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            SignInWithAppleSwiftUIButton()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
