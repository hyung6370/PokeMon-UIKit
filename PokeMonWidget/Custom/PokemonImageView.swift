//
//  PokemonImageView.swift
//  PokemonWidgetExtension
//
//  Created by Hyungjun KIM on 3/4/25.
//

import SwiftUI

struct PokemonImageView: View {
    let url: URL
    @State private var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        } else {
            ProgressView()
                .frame(width: 80, height: 80)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .onAppear {
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let originalImage = UIImage(data: data) {
                    let convertedImage = originalImage.convertIndexedPNGToRGB()
                    DispatchQueue.main.async {
                        self.image = convertedImage
                    }
                }
            } catch {
                print("❌ 이미지 로드 실패: \(error)")
            }
        }
    }
}
