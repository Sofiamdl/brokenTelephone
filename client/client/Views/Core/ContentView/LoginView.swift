//
//  ContentView.swift
//  client
//
//  Created by sml on 20/03/23.
//

import SwiftUI
import AuthenticationServices
import Combine

struct UserResponse: Codable {
    let user: SentUser
}

let loginViewModel = LoginViewModel()


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
    
    func placeOrder(id: String, completion: @escaping (_ result: Bool) -> Void) {
        let url = URL(string: "http://localhost:3001/users/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(false)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("erro1")
                completion(false)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(UserResponse.self, from: data)
                completion(true)
                loginViewModel.user = user.user
                print (loginViewModel.user)
                return
            } catch {
                
                completion(false)
                return
            }
        }
        
        task.resume()
    }
    
    
    func SignInButton(_ type: SignInWithAppleButton.Style) -> some View {
        return SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authResults):
                print("Authorisation successful \(authResults)")
                switch authResults.credential {
                case let authAppleCredential as ASAuthorizationAppleIDCredential:
                    print (authAppleCredential.user)
                    Task {
                        placeOrder(id: authAppleCredential.user) { result in
                            if result == true
                            {
                                print ("due certo")
                            }
                            else {
                                print ("turo eddado")
                            }
                        }
                    }
                    
                    break
                default:
                    break
                }
            case .failure(let error):
                print("Authorisation failed: \(error.localizedDescription)")
            }
        }
        .frame(width: 280, height: 60, alignment: .center)
        .signInWithAppleButtonStyle(type)
    }
}

struct LoginPage: View {
    var user: SentUser?
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("OXE!")
            SignInWithAppleSwiftUIButton()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
