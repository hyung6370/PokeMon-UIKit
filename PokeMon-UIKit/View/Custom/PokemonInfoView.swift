//
//  PokemonInfoView.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/18/25.
//

import UIKit
import SnapKit
import Then

final class PokemonInfoView: UIView {
    // MARK: - Properties
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.addShadow(
            offset: CGSize(width: 0, height: 3),
            color: .black,
            shadowRadius: 8.0,
            opacity: 0.3,
            cornerRadius: 12
        )
    }
    
    private var nameLabel = UILabel().then {
        $0.font = ThemeFont.demiBold(ofSize: 22)
        $0.textAlignment = .center
    }
    
    private var firstTypeLabel = TypeLabel()
    private var secondTypeLabel = TypeLabel()
    
    private var weightLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private var heightLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private lazy var typeHStackView = UIStackView(arrangedSubviews: [firstTypeLabel, secondTypeLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    private lazy var weightHeightHStackView = UIStackView(arrangedSubviews: [weightLabel, heightLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
    }
    
    private lazy var vStackView = UIStackView(arrangedSubviews: [nameLabel, typeHStackView, weightHeightHStackView]).then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
    }
}
