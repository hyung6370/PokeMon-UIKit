//
//  FavViewController.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/24/25.
//

import UIKit

class FavViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart.fill"), tag: 2)
        view.backgroundColor = .blue
        
    }
}
