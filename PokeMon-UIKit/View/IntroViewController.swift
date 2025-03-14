//
//  IntroViewController.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 3/7/25.
//

import UIKit
import SnapKit
import Then
import Lottie

class IntroViewController: UIViewController {
    private let selectedAnimation: String
    private let animationView: LottieAnimationView
    
    init() {
        let animations = ["first", "second"]
        self.selectedAnimation = animations.randomElement() ?? "first"
        self.animationView = LottieAnimationView(name: self.selectedAnimation)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        playAnimation()
    }
    
    private func configureUI() {
        view.backgroundColor = selectedAnimation == "first" ? UIColor(hex: "FFFADD") : UIColor(hex: "EBF5E0")
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        
        view.addSubview(animationView)
        
        animationView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(300)
        }
    }
    
    private func playAnimation() {
//        끝나자마자 바로 메인으로 이동
//        animationView.play { [weak self] finished in
//            if finished {
//                self?.moveToMainScreen()
//            }
//        }
        
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.fadeOutAndMoveToMainScreen()
        }
    }
    
    private func fadeOutAndMoveToMainScreen() {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 0
        }) { _ in
            self.moveToMainScreen()
        }
    }
    
    private func moveToMainScreen() {
        let pokedexService = PokedexService()
        let listVM = ListViewModel(pokedexService: pokedexService)
        let mainVC = ListViewController(viewModel: listVM)
        let nav = UINavigationController(rootViewController: mainVC)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = nav
            sceneDelegate.window?.makeKeyAndVisible()
            
            UIView.transition(with: sceneDelegate.window!, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
            
            if let deepLinkURL = sceneDelegate.pendingDeepLinkURL {
                sceneDelegate.pendingDeepLinkURL = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    sceneDelegate.handleDeepLink(deepLinkURL)
                }
            }
        }
    }
}
