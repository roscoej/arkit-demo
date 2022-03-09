//
//  ImagePreview.swift
//  SwiftUI ARKit Test
//
//  Created by Jacob Roscoe on 3/9/22.
//

import SwiftUI

struct ImagePreview: View {
    @Binding var imageURL: URL?
    var body: some View {
        ZStack {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    EmptyView()
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
            }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 5)
    }
}
