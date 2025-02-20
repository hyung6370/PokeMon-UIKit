//
//  ImageContainerView.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/18/25.
//

import UIKit
import SnapKit
import Then
import SDWebImage

final class ImageContainerView: UIView {
    // MARK: - Properties
    private let containerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var pokemonImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func layout() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(pokemonImageView)
        pokemonImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(15)
        }
    }
    
    func configure(imageUrl: String) {
        let url = URL(string: imageUrl)
        pokemonImageView.sd_setImage(with: url)
    }
    
    func setContainerViewShadow() {
        containerView.addShadow(
            offset: CGSize(width: 0, height: 3),
            color: .black,
            shadowRadius: 8.0,
            opacity: 0.3,
            cornerRadius: 0
        )
    }
    
    func setContainerViewCornerRadius(radius: CGFloat) {
        containerView.addCornerRadius(radius: radius)
    }
    
    func setContainerViewCornerRadius(corners: CACornerMask, radius: CGFloat) {
        containerView.addRoundedCorners(corners: corners, radius: radius)
    }
    
    func setContainerViewBackgroundColor(color: UIColor?) {
        containerView.backgroundColor = color
    }
    
    func setContainerViewGradientLayer(colors: [CGColor]) -> CAGradientLayer {
        return containerView.addGradientLayer(colors: colors)
    }
    
    func setImageViewContentInset(inset: CGFloat) {
        pokemonImageView.snp.remakeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(inset)
            $0.top.equalToSuperview().inset(inset + 50)
        }
    }
}
