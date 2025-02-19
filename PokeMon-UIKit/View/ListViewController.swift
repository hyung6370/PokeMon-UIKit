//
//  ListViewController.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/18/25.
//

import UIKit
import Combine
import CombineCocoa
import SnapKit
import Then

class ListViewController: UIViewController {
    // MARK: - Properties
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout()).then {
        $0.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)
        $0.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        $0.delaysContentTouches = false
    }
    
    
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewLayout()
        let width = view.frame.width/2 - 15
        layout.itemsize = .init(width: width, height: width + 100)
        return layout
    }
    
    
}
