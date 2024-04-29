//
//  APIService.swift
//  AppStoreSearchSwiftUI
//
//  Created by Ivan Morgun on 24.04.2024.
//

import Foundation

struct APIService {
    enum APIError: Error {
        case notFound, badResponse(statusCode: Int), badURL
    }
    
    static func fetchAppDetail(for item: ItunesApp) async throws -> Lookup? {
        let url = "https://itunes.apple.com/lookup?id=\(item.trackId)"
        let response: LookupResults = try await decode(urlString: url)
        return response.results.first
    }
    
    static func fetchSearchResults(term: String, entity: String = "software") async throws -> [ItunesApp] {
        let url = "https://itunes.apple.com/search?term=\(term)&entity=\(entity)"
        let response: ItunesApps = try await decode(urlString: url)
        return response.results
    }
    
    static func fetchReviews(trackId: Int) async throws -> [ReviewEntry] {
        let url = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(trackId)/sortby=mostrecent/json?l=en&cc=us"
        let response: ReviewResult = try await decode(urlString: url)
        return response.feed.entry
    }
    
    static private func decode<T: Codable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw APIError.badURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        if let statusCode = (response as? HTTPURLResponse)?.statusCode, !(200..<299 ~= statusCode) {
            throw APIError.badResponse(statusCode: statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
