//
//  TypeLabel.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/18/25.
//

import UIKit

final class TypeLabel: UILabel {
    var verticalPadding: CGFloat = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    var horizontalPadding: CGFloat = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let baseSize = super.intrinsicContentSize
        
        return CGSize(width: baseSize.width + horizontalPadding, height: baseSize.height + verticalPadding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        verticalPadding = 5
        font = ThemeFont.bold(ofSize: 16)
        clipsToBounds = true
        layer.cornerRadius = 5
        textAlignment = .center
        textColor = .white
    }
}
