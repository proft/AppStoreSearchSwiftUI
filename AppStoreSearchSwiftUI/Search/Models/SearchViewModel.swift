//
//  SearchViewModel.swift
//  AppStoreSearchSwiftUI
//
//  Created by Ivan Morgun on 05.04.2024.
//

import SwiftUI
import Combine

struct ItunesApps: Codable {
    let results: [ItunesApp]
}

struct ItunesApp: Codable {
    let trackId: Int
    let trackName: String
    let artworkUrl512: String
    let primaryGenreName: String
    let screenshotUrls: [String]
    let averageUserRating: Double
    let userRatingCount: Int
}

@MainActor
class SearchViewModel: ObservableObject {
    @Published var items: [ItunesApp] = []
    @Published var query = ""
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $query
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] newValue in
                print(newValue)
                self?.fetchData(term: newValue)
            }.store(in: &cancellables)
    }
    
    private func fetchData(term: String, entity: String = "software") {
        Task {
            isLoading = true
            do {
                self.items = try await APIService.fetchSearchResults(term: term, entity: entity)
            } catch {
                print("ERROR:", error)
            }
            isLoading = false
        }
    }
}
