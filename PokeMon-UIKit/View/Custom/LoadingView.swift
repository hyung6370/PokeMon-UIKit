//
//  LoadingView.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/19/25.
//

import UIKit
import SnapKit
import Then

final class LoadingView: UIView {
    // MARK: - Properties
    private let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.5
    }
    
    private let oneDotView = UIView().then {
        $0.backgroundColor = .darkGray
        $0.clipsToBounds = true
    }
    
    private let twoDotView = UIView().then {
        $0.backgroundColor = .darkGray
        $0.clipsToBounds = true
    }
    
    private let threeDotView = UIView().then {
        $0.backgroundColor = .darkGray
        $0.clipsToBounds = true
    }
    
    private lazy var hStackView = UIStackView(arrangedSubviews: [oneDotView, twoDotView, threeDotView]).then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func layout() {
        isHidden = true
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.addSubview(hStackView)
        hStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        
        [oneDotView, twoDotView, threeDotView].forEach { view in
            view.snp.makeConstraints {
                $0.size.equalTo(12)
            }
            
            view.addCornerRadius(radius: 6)
        }
    }
    
    func setLoadingViewCornerRadius() {
        backgroundView.addCornerRadius(radius: backgroundView.frame.height/2)
    }
    
    func showLoadingViewAndStartAnimation() {
        isHidden = false
        
        
    }
    
    func hideLoadingViewAndStopAnimation() {
        self.isHidden = true
        
        [oneDotView, twoDotView, threeDotView].forEach { $0.layer.removeAllAnimations() }
    }
    
    private func makeOpacityKeyFrame() -> CAKeyframeAnimation {
        let opacityKeyframe = CAKeyframeAnimation(keyPath: "opacity")
        opacityKeyframe.values = [0.3, 1.0, 0.3]
        opacityKeyframe.keyTimes = [0, 0.5, 1]
        opacityKeyframe.duration = 1.5
        opacityKeyframe.repeatCount = .infinity
        
        return opacityKeyframe
    }
}
