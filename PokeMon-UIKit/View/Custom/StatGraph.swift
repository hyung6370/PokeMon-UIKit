//
//  StatGraph.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/19/25.
//

import UIKit
import SnapKit
import Then

final class StatGraph: UIView {
    private let nameLabel = UILabel().then {
        $0.font = ThemeFont.regular(ofSize: 14)
        $0.textColor = .darkGray
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.textAlignment = .center
    }
    
    private let graphBackground = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.addCornerRadius(radius: 15)
    }
    
    private lazy var hStackView = UIStackView(arrangedSubviews: [nameLabel, graphBackground]).then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let graphView = UIView().then {
        $0.addCornerRadius(radius: 15)
    }
    
    private let statLabel = UILabel().then {
        $0.textColor = .white
        $0.font = ThemeFont.regular(ofSize: 12)
        $0.layer.opacity = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(hStackView)
        hStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.width.equalTo(50)
        }
        
        graphBackground.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        graphBackground.addSubview(graphView)
        graphView.snp.makeConstraints {
            $0.left.bottom.top.equalToSuperview()
            $0.width.equalTo(0)
        }
        
        graphView.addSubview(statLabel)
        statLabel.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
        }
    }
    
    func configure(
        statName: String,
        statValue: Int,
        statColor: UIColor
    ) {
        nameLabel.text = statName
        statLabel.text = "\(statValue)/300"
        graphView.backgroundColor = statColor
        
        print("🔵 StatGraph.configure() 실행됨 - \(statName): \(statValue), 색상: \(statColor)")
        
        DispatchQueue.main.async {
            self.updateGraph(statValue: statValue, statColor: statColor)
        }
    }
    
    private func updateGraph(statValue: Int, statColor: UIColor) {
        self.layoutIfNeeded()
        
        let graphWidth = self.graphBackground.frame.width / 300.0 * CGFloat(statValue)
        
        print("🟢 graphWidth: \(graphWidth), backgroundWidth: \(self.graphBackground.frame.width)")

        if graphWidth <= 50 {
            statLabel.snp.remakeConstraints {
                $0.left.equalTo(graphView.snp.right).offset(5)
                $0.top.bottom.equalToSuperview()
            }
            statLabel.textColor = .black
        } else {
            statLabel.snp.remakeConstraints {
                $0.right.equalTo(graphView.snp.right).inset(5)
                $0.top.bottom.equalToSuperview()
            }
            statLabel.textColor = .white
        }
        
        self.graphView.snp.updateConstraints {
            $0.width.equalTo(graphWidth)
        }
        
        UIView.animate(withDuration: 1.5) {
            self.statLabel.layer.opacity = 1
            self.layoutIfNeeded()
        }
    }
}
