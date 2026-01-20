//
//  SceneDelegate.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/17/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var pendingDeepLinkURL: URL?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let introVC = IntroViewController()
        let navigationController = UINavigationController(rootViewController: introVC)
        
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        if let urlContext = connectionOptions.urlContexts.first {
            pendingDeepLinkURL = urlContext.url
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        
        if let navigationController = window?.rootViewController as? UINavigationController,
           navigationController.topViewController is IntroViewController {
            pendingDeepLinkURL = url
        } else {
            handleDeepLink(url)
        }
    }
    
    func handleDeepLink(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              components.host == "detail",
              let queryItems = components.queryItems,
              let idString = queryItems.first(where: { $0.name == "id" })?.value,
              let pokemonID = Int(idString) else { return }
        
        // App Group에서 데이터 가져오기
        let pokemonList = PokeMonWidgetManager.shared.fetchPokemonList()
        guard let selectedPokemon = pokemonList.first(where: { $0.id == pokemonID }) else {
            print("❌ 위젯 데이터에서 포켓몬을 찾을 수 없음")
            return
        }
        
        guard let nav = window?.rootViewController as? UINavigationController else { return }
        
        nav.dismiss(animated: false)
        
        let detailVM = DetailViewModel(pokemon: selectedPokemon)
        let detailVC = DetailViewController(viewModel: detailVM)
        nav.pushViewController(detailVC, animated: true)
    }
}

