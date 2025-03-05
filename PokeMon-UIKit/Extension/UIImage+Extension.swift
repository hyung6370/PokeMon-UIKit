//
//  UIImage+Extension.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 3/4/25.
//

import UIKit

extension UIImage {
    func convertIndexedPNGToRGB() -> UIImage {
        guard let ciImage = CIImage(image: self) else { return self }
        
        let ciContext = CIContext(options: nil)
        if let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        } else {
            print("❌ Core Image 변환 실패")
            return self
        }
    }
}

