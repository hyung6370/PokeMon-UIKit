//
//  PokemonStatView.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/19/25.
//

import UIKit
import SnapKit
import Then

final class PokemonStatView: UIView {
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
    
    private let titleLabel = UILabel().then {
        $0.text = "기본 스탯!"
        $0.font = ThemeFont.bold(ofSize: 14)
        $0.textAlignment = .center
    }
    
    private let hpStatView: StatGraph = StatGraph()
    private let atkStatView: StatGraph = StatGraph()
    private let defStatView: StatGraph = StatGraph()
    private let spdStatView: StatGraph = StatGraph()
    
    private lazy var vStackView = UIStackView(arrangedSubviews: [titleLabel, hpStatView, atkStatView, defStatView, spdStatView]).then {
        $0.axis = .vertical
        $0.spacing = 12
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
            $0.edges.equalToSuperview().inset(20)
        }
        
        containerView.addSubview(vStackView)
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func configure(viewModel: DetailViewModel) {
        hpStatView.configure(statName: "HP", statValue: viewModel.hp, statColor: .systemRed)
        atkStatView.configure(statName: "ATK", statValue: viewModel.attack, statColor: .systemYellow)
        defStatView.configure(statName: "DEF", statValue: viewModel.defense, statColor: .systemBlue)
        spdStatView.configure(statName: "SPD", statValue: viewModel.speed, statColor: .systemGray)
    }
}
