//
//  ReviewResult.swift
//  AppStoreSearchSwiftUI
//
//  Created by Ivan Morgun on 18.04.2024.
//

import Foundation

struct ReviewResult: Codable {
    let feed: ReviewFeed
}

struct ReviewFeed: Codable {
    let entry: [ReviewEntry]
}

struct LabelValue: Codable {
    let label: String
}

struct ReviewEntry: Codable, Identifiable {
    var id: String { content.label }
    let content: LabelValue
    let title: LabelValue
    let author: Author
    let rating: LabelValue
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case content
        case rating = "im:rating"
    }
}

struct Author: Codable {
    let name: LabelValue
}
