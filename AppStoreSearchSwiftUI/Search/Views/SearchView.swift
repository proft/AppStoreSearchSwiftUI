//
//  ContentView.swift
//  AppStoreSearchSwiftUI
//
//  Created by Ivan Morgun on 03.04.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var vm = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ZStack {
                    if vm.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .controlSize(.large)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    if vm.items.isEmpty && vm.query.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.system(size: 60))
                            
                            Text("Please enter your search terms above")
                                .font(.system(size: 24, weight: .semibold))
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView {
                            ForEach(vm.items, id: \.trackId) { item in
                                NavigationLink(destination:
                                                SearchDetailView(item: item),
                                               label: {
                                                SearchCellView(item: item, proxy: proxy)
                                })
                                .foregroundStyle(Color(.label))
                                .padding(16)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $vm.query, prompt: "Enter search term")
        }
    }
}
                            
#Preview {
    SearchView()
}
