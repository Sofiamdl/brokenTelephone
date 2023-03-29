//
//  ContentViewModel.swift
//  client
//
//  Created by sml on 28/03/23.
//  
//

import SwiftUI

// MARK: Variables to watch mark as Published. ViewModel also calls API/Core Data

final class ContentViewModel: ObservableObject {
    @Published var example: String?
}