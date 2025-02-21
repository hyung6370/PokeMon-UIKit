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
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func layout() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-50)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        containerView.addSubview(vStackView)
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func configure(viewModel: DetailViewModel) {
        nameLabel.text = viewModel.koreanName
        firstTypeLabel.text = viewModel.firstTypeName
        secondTypeLabel.text = viewModel.secondTypeName
        firstTypeLabel.backgroundColor = viewModel.firstTypeColor
        secondTypeLabel.backgroundColor = viewModel.secondTypeColor
        weightLabel.attributedText = viewModel.weightText
        heightLabel.attributedText = viewModel.heightText
        
        if secondTypeLabel.text == nil {
            secondTypeLabel.isHidden = true
        }
    }
}
