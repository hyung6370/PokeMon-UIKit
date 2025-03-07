//
//  PokemonCell.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/18/25.
//

import UIKit
import SnapKit
import Then
import SDWebImage
import Combine

final class PokemonCell: UICollectionViewCell {
    // MARK: - Properties
    lazy var pokemonImageView = ImageContainerView()
    
    private var tagLabel = UILabel().then {
        $0.font = ThemeFont.bold(ofSize: 14)
        $0.textColor = .lightGray
    }
    
    private var nameLabel = UILabel().then {
        $0.font = ThemeFont.bold(ofSize: 18)
        $0.textColor = .black
    }
    
    private var firstTypeLabel = TypeLabel()
    private var secondTypeLabel = TypeLabel()
    
    private lazy var typeStackView = UIStackView(arrangedSubviews: [firstTypeLabel, secondTypeLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fillEqually
    }
    
    private lazy var vStackView = UIStackView(arrangedSubviews: [pokemonImageView, tagLabel, nameLabel, typeStackView]).then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    static let identifier = "PokemonCell"
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        tagLabel.text = ""
        nameLabel.text = ""
        firstTypeLabel.text = ""
        secondTypeLabel.text = ""
        firstTypeLabel.backgroundColor = .clear
        secondTypeLabel.backgroundColor = .clear
        pokemonImageView.configure(imageUrl: "")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Helpers
    private func layout() {
        contentView.addSubview(vStackView)
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pokemonImageView.snp.makeConstraints {
            $0.height.equalTo(contentView.snp.width)
        }
        
        pokemonImageView.setContainerViewShadow()
        pokemonImageView.setContainerViewCornerRadius(radius: 12)
    }
    
    func configure(pokemon: Pokemon) {
        pokemonImageView.configure(imageUrl: pokemon.imageUrl)
        pokemonImageView.setContainerViewBackgroundColor(
            color: ThemeColor.typeColor(type: pokemon.pokemonTypes.first ?? .normal).withAlphaComponent(0.6)
        )
        tagLabel.text = "No.\(pokemon.tag)"
        nameLabel.text = pokemon.koreanName ?? pokemon.name
        firstTypeLabel.text = pokemon.pokemonTypes.first?.rawValue
        firstTypeLabel.backgroundColor = ThemeColor.typeColor(type: pokemon.pokemonTypes.first!)
        if pokemon.pokemonTypes.count >= 2 {
            secondTypeLabel.text = pokemon.pokemonTypes[1].rawValue
            secondTypeLabel.backgroundColor = ThemeColor.typeColor(type: pokemon.pokemonTypes[1])
        }
        pokemonImageView.layoutIfNeeded()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        bounceAnimate(isTouched: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        bounceAnimate(isTouched: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        bounceAnimate(isTouched: false)
    }
    
    private func bounceAnimate(isTouched: Bool) {
        if isTouched {
            PokemonCell.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: [.allowUserInteraction],
                animations: {
                    self.transform = .init(scaleX: 0.96, y: 0.96)
                    self.layoutIfNeeded()
                }, completion: nil
            )
        } else {
            PokemonCell.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: [.allowUserInteraction],
                animations: {
                    self.transform = .identity
                }, completion: nil
            )
        }
    }
}
