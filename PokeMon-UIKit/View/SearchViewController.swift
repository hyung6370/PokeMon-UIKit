//
//  SearchViewController.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/24/25.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        view.backgroundColor = .red
    }
}
