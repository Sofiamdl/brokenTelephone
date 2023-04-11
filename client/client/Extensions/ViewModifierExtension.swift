//
//  ViewModifier.swift
//  client
//
//  Created by sml on 11/04/23.
//

import Combine
import SwiftUI

final class KeyboardResponder: ObservableObject {
        private var notificationCenter: NotificationCenter
        @Published private(set) var currentHeight: CGFloat = 0
        
        init(center: NotificationCenter = .default) {
                notificationCenter = center
                notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        deinit {
                notificationCenter.removeObserver(self)
        }
        
        @objc func keyBoardWillShow(notification: Notification) {
                if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                        currentHeight = keyboardSize.height
                }
        }
        
        @objc func keyBoardWillHide(notification: Notification) {
                currentHeight = 0
        }
}

struct KeyboardAwareModifier: ViewModifier {
        @State private var keyboardHeight: CGFloat = 0
        private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
                Publishers.Merge(
                        NotificationCenter.default
                                .publisher(for: UIResponder.keyboardWillShowNotification)
                                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
                                .map { $0.cgRectValue.height },
                        NotificationCenter.default
                                .publisher(for: UIResponder.keyboardWillHideNotification)
                                .map { _ in CGFloat(0) }
             ).eraseToAnyPublisher()
        }
        func body(content: Content) -> some View {
                content
                        .padding(.bottom, keyboardHeight)
                        .onReceive(keyboardHeightPublisher) { self.keyboardHeight = $0 }
                        
        }
}

extension View {
    func KeyboardAwarePadding(background: Color) -> some View {
                ModifiedContent(content: self, modifier: KeyboardAwareModifier())
                .background(background)
        }
}
