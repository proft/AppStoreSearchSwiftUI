//
//  ReviewsView.swift
//  AppStoreSearchSwiftUI
//
//  Created by Ivan Morgun on 18.04.2024.
//

import SwiftUI

struct ReviewsView: View {
    @StateObject var vm: ReviewsViewModel
    
    private let proxy: GeometryProxy
    
    init(trackId: Int, proxy: GeometryProxy) {
        self.proxy = proxy
        self._vm = .init(wrappedValue: .init(trackId: trackId))
    }
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(vm.entries) { review in
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text(review.title.label)
                                .lineLimit(1)
                                .font(.system(size: 20, weight: .semibold))
                            Spacer()
                            Text(review.author.name.label)
                                .lineLimit(1)
                                .foregroundStyle(Color(.lightGray))
                        }
                        
                        HStack(spacing: 0) {
                            if let rating = Int(review.rating.label) {
                                ForEach(0..<rating, id: \.self) { num in
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.orange)
                                }
                                
                                ForEach(0..<5 - rating, id: \.self) { num in
                                    Image(systemName: "star")
                                        .foregroundStyle(.orange)
                                }
                            }
                        }
                        
                        Text(review.content.label)
                        Spacer()
                    }
                    .padding(20)
                    .frame(width: max(0, proxy.size.width - 64), height: 220)
                    .background(Color(.init(white: 1, alpha: 0.1)))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal, 16)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)        
    }
}
