//
//  SearchCellView.swift
//  AppStoreSearchSwiftUI
//
//  Created by Ivan Morgun on 05.04.2024.
//

import SwiftUI

struct SearchCellView: View {
    let item: ItunesApp
    let proxy: GeometryProxy
    
    let spacing: CGFloat = 16
    var width: CGFloat? = nil
    
    init(item: ItunesApp, proxy: GeometryProxy) {
        self.item = item
        self.proxy = proxy
        width = (proxy.size.width  - 4 * spacing) / 3
        width = (width ?? 0) > 0 ? width : nil
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: item.artworkUrl512)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 80, height: 80)
                }
                
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .lineLimit(1)
                        .font(.system(size: 20))
                    Text(item.primaryGenreName)
                        .foregroundStyle(Color(.gray))
                    
                    HStack(spacing: 1) {
                        ForEach(0..<Int(item.averageUserRating), id: \.self) { num in
                            Image(systemName: "star.fill")
                        }
                        ForEach(0..<5 - Int(item.averageUserRating), id: \.self) { num in
                            Image(systemName: "star")
                        }
                        
                        Text("\(item.userRatingCount.roundedWithAbbreviations)")
                            .padding(.leading, 4)
                    }
                    .padding(.top, 0)
                }
                
                Image(systemName: "icloud.and.arrow.down")
                    .foregroundColor(.blue)
            }
            
            HStack(spacing: spacing) {
                ForEach(item.screenshotUrls.prefix(3), id: \.self) { url in
                    AsyncImage(url: URL(string: url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            //.frame(width: width, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: width, height: 200)
                    }
                }
            }
        }
    }
}
