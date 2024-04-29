//
//  ReviewsViewModel.swift
//  AppStoreSearchSwiftUI
//
//  Created by Ivan Morgun on 19.04.2024.
//

import SwiftUI

@MainActor
class ReviewsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var entries: [ReviewEntry] = [ReviewEntry]()
    
    private let trackId: Int
    
    init(trackId: Int) {
        self.trackId = trackId
        fetchReviews()
    }
    
    func fetchReviews() {
        Task {
            isLoading = true
            do {
                self.entries = try await APIService.fetchReviews(trackId: trackId)
            } catch {
                print("ERROR:", error)
            }
            
            isLoading = false
        }
    }
}
