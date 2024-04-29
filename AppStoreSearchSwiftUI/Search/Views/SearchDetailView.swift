//
//  SearchDetailView.swift
//  AppStoreSearchSwiftUI
//
//  Created by Ivan Morgun on 13.04.2024.
//

import SwiftUI

struct SearchDetailView: View {
    @StateObject var vm: SearchDetailViewModel
    
    init(item: ItunesApp) {
        self._vm = .init(wrappedValue: SearchDetailViewModel(item: item))
    }
    
    var body: some View {
        GeometryReader { proxy in
            if let error = vm.error {
                Text("Failed to fetch app details: \(error.localizedDescription)")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.title)
                    .padding()
            }
            
            ScrollView {
                if let lookup = vm.lookup {
                    HStack(spacing: 16) {
                        AsyncImage(url: URL(string: lookup.artworkUrl512)) { image in
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .scaledToFill()
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 100, height: 100)
                        }
                        VStack(alignment: .leading) {
                            Text(lookup.trackName)
                                .font(.system(size: 24, weight: .semibold))
                            Text(lookup.artistName)
                            Image(systemName: "icloud.and.arrow.down")
                                .font(.system(size: 24))
                                .padding(.vertical, 4)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    // What's New
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("What's New")
                                .font(.system(size: 24, weight: .semibold))
                                .padding(.vertical)
                            Spacer()
                            Button(action: {}) {
                                Text("Version History")
                            }
                        }
                        Text(lookup.releaseNotes)
                    }
                    .padding(.horizontal)
                    
                    // Preview
                    
                    screenshotsView
                    
                    // Reviews
                    
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.system(size: 24, weight: .semibold))
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    ReviewsView(trackId: vm.item.trackId, proxy: proxy)
                    
                    // Description
                    
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.system(size: 24, weight: .semibold))
                            .padding(.vertical)
                        Text(lookup.description)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var screenshotsView: some View {
        VStack {
            Text("Preview")
                .font(.system(size: 24, weight: .semibold))
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(vm.lookup?.screenshotUrls ?? [], id: \.self) { url in
                        Button(action: {
                            vm.isScreenshotsFullscreen.toggle()
                        }, label: {
                            AsyncImage(url: URL(string: url)) { image in
                                image
                                    .resizable()
                                    .frame(width: 200, height: 350)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .scaledToFill()
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 200, height: 350)
                                    .foregroundStyle(Color(.label))
                            }
                        })
                    }
                }
                .padding(.horizontal)
            }
        }
        .fullScreenCover(isPresented: $vm.isScreenshotsFullscreen) {
            FullScreenShotsView(screenshotUrls: vm.lookup?.screenshotUrls ?? [])
        }
    }
}

