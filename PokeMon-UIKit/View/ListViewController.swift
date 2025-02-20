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
    
    private let loadingView: LoadingView = .init(frame: .zero)
    private var cancellables: Set<AnyCancellable> = .init()
    
    var selectedCell: PokemonCell?
    private let viewModel: ListViewModel
    
    // MARK: - LifeCycle
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Pokedex"
        layout()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
        
        loadingView.setLoadingViewCornerRadius()
    }
    
    // MARK: - Helpers
    private func layout() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    private func bind() {
        viewModel.setupDataSource(collectionView: self.collectionView)
        viewModel.pokemonListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pokemons in
                if pokemons.count % 20 == 0 {
                    self?.viewModel.updateCollectionView(with: pokemons)
                    self?.loadingView.hideLoadingViewAndStopAnimation()
                }
            }.store(in: &cancellables)
        
        collectionView.reachedBottomPublisher()
            .sink { [weak self] _ in
                self?.loadingView.showLoadingViewAndStartAnimation()
                self?.viewModel.nextPage()
            }.store(in: &cancellables)
        
        collectionView.didSelectItemPublisher
            .sink { [weak self] indexPath in
                self?.didSelectItem(at: indexPath)
            }.store(in: &cancellables)
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width/2 - 15
        layout.itemSize = .init(width: width, height: width + 100)
        return layout
    }
    
    private func didSelectItem(at indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PokemonCell else { return }
        selectedCell = cell
        
        let pokemon = viewModel.pokemonList[indexPath.row]
        let detailVM = DetailViewModel(pokemon: pokemon)
        let detailVC = DetailViewController(viewModel: detailVM)
        
        detailVC.modalPresentationStyle = .custom
        detailVC.transitioningDelegate = detailVC
        detailVC.modalPresentationCapturesStatusBarAppearance = true
        
        present(detailVC, animated: true)
    }
}
