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
            
        }
    }
    
    func handleDeepLink(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              components.host == "detail",
              let queryItems = components.queryItems,
              let idString = queryItems.first(where: { $0.name == "id" })?.value,
              let pokemonID = Int(idString) else {
            print("❌ 딥링크 URL 분석 실패: \(url)")
            return
        }
        
        print("🔗 딥링크: 포켓몬 ID = \(pokemonID)")
        
        guard let navigationController = window?.rootViewController as? UINavigationController else {
            print("❌ 네비게이션 컨트롤러가 없음")
            return
        }
        
        let pokemonList = PokeMonWidgetManager.shared.fetchPokemonList()
        print("📄 불러온 포켓몬 개수: \(pokemonList.count)개")
        
        guard let selectedPokemon = pokemonList.first(where: { $0.id == pokemonID }) else {
            print("❌ 해당 ID의 포켓몬 없음: \(pokemonID)")
            return
        }
        
        print("✅ 선택된 포켓몬: \(selectedPokemon.koreanName ?? "알 수 없음")")
        
        let viewModel = DetailViewModel(pokemon: selectedPokemon)
        let detailVC = DetailViewController(viewModel: viewModel)
        
        navigationController.pushViewController(detailVC, animated: true)
    }
}

