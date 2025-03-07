//
//  SceneDelegate.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/17/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
//        let window = UIWindow(windowScene: windowScene)
//        let pokedexService = PokedexService()
//        let listVM = ListViewModel(pokedexService: pokedexService)
//        let mainVC = ListViewController(viewModel: listVM)
//        let nav = UINavigationController(rootViewController: mainVC)
//        
//        window.rootViewController = nav
//        self.window = window
//        window.makeKeyAndVisible()
        
        let window = UIWindow(windowScene: windowScene)
        let introVC = IntroViewController()
        
        window.rootViewController = introVC
        self.window = window
        window.makeKeyAndVisible()
    }
}

