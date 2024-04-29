//
//  SearchDetailViewModel.swift
//  AppStoreSearchSwiftUI
//
//  Created by Ivan Morgun on 28.04.2024.
//

import SwiftUI

struct LookupResults: Codable {
    let resultCount: Int
    let results: [Lookup]
}

struct Lookup: Codable {
    let artistName: String
    let trackName: String
    let releaseNotes: String
    let description: String
    let screenshotUrls: [String]
    let artworkUrl512: String
}

@MainActor
class SearchDetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var lookup: Lookup?
    @Published var error: Error?
    @Published var isScreenshotsFullscreen: Bool = false
    
    var item: ItunesApp
    
    init(item: ItunesApp) {
        self.item = item
        fetchData()
    }
    
    private func fetchData() {
        Task {
            isLoading = true
            do {
                self.lookup = try await APIService.fetchAppDetail(for: item)
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
}
