//
//  HomeViewController.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import UIKit
import Combine

class HomeViewController: KUIViewController {
    
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    private var collectionView: UITableView? = UITableView()
    private var searchBar: UISearchBar? = UISearchBar()
    private var model: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
        model.loadList()
        registerCell()
    }
    
    private func bind() {
        model.reloadPublisher
            .sink {
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView?.reloadData()
                }
            }
            .store(in: &bag)
        searchBar?.delegate = self
        collectionView?.delegate = self
        collectionView?.dataSource = model
    }
    
    private func registerCell() {
        collectionView?.register(CoinSimpleCell.self, forCellReuseIdentifier: CoinSimpleCell.reuseIdentifier)
    }
    
    private func configureUI() {
        configureSearchBar()
        configureCollectionView()
    }
    
    private func configureSearchBar() {
        searchBar?.removeFromSuperview()
        searchBar?.translatesAutoresizingMaskIntoConstraints = false
        
        guard let view = searchBar else { return }
        self.container.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.container.topAnchor),
            view.leftAnchor.constraint(equalTo: self.container.leftAnchor),
            view.rightAnchor.constraint(equalTo: self.container.rightAnchor),
            view.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func configureCollectionView() {
        collectionView?.removeFromSuperview()
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        guard let view = collectionView,
              let topNeighbor = searchBar else { return }
        self.container.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topNeighbor.bottomAnchor, constant: 0),
            view.leftAnchor.constraint(equalTo: self.container.leftAnchor),
            view.rightAnchor.constraint(equalTo: self.container.rightAnchor),
            view.bottomAnchor.constraint(equalTo: self.container.bottomAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = model.getCoin(forIndex: indexPath.row)
        let controllerModel = CoinViewModel(with: coin)
        let controller = CoinViewController(withModel: controllerModel)
        self.modalPresentationStyle = .formSheet
        self.present(controller, animated: true, completion: nil)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.filter(with: searchText)
    }
}
