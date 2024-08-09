//
//  MealThumbnailView.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/8/24.
//

import Foundation
import SwiftUI

struct MealThumbnailView: View {
    let thumbnailURL: URL?
    
    var body: some View {
        AsyncImage(url: thumbnailURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
            case .failure:
                Image(systemName: "photo")
                    .foregroundColor(.gray)
                    .scaledToFit()
            @unknown default:
                EmptyView()
            }
        }
    }
}
