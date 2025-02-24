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
        
        let window = UIWindow(windowScene: windowScene)
        let pokedexService = PokedexService()
        let listVM = ListViewModel(pokedexService: pokedexService)
        let mainVC = ListViewController(viewModel: listVM)
        let nav = UINavigationController(rootViewController: mainVC)
        
        window.rootViewController = nav
        self.window = window
        window.makeKeyAndVisible()
        
//        self.window = UIWindow(windowScene: windowScene)
//        
//        let pokdexService = PokedexService()
//        let listVM = ListViewModel(pokedexService: pokdexService)
//        let listNav = UINavigationController(rootViewController: ListViewController(viewModel: listVM))
//        let searchNav = UINavigationController(rootViewController: SearchViewController())
//        let favNav = UINavigationController(rootViewController: FavViewController())
//        
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [listNav, searchNav, favNav]
//        self.window?.rootViewController = tabBarController
//        self.window?.makeKeyAndVisible()
        
    }
}

