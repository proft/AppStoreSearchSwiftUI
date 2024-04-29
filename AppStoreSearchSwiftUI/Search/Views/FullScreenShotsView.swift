//
//  FullScreenShotsView.swift
//  AppStoreSearchSwiftUI
//
//  Created by Ivan Morgun on 17.04.2024.
//

import SwiftUI

struct FullScreenShotsView: View {
    @Environment(\.dismiss) var dismiss
    
    let screenshotUrls: [String]
    
    var body: some View {
        GeometryReader { gr in
            ZStack {
                VStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(.label))
                            .font(.system(size: 24, weight: .semibold))
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(screenshotUrls, id: \.self) { url in
                            let width = gr.size.width - 64
                            
                            AsyncImage(url: URL(string: url)) { image in
                                image
                                    .resizable()
                                    .frame(width: width, height: 550)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .scaledToFill()
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: width, height: 550)
                                    .foregroundStyle(Color(.label))
                            }
                        }
                    }
                    .padding(.horizontal, 32)
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
            }
        }
    }
}
