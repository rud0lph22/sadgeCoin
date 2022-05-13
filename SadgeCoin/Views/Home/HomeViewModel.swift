//
//  HomeViewModel.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import Foundation
import Combine
import UIKit

class HomeViewModel: NSObject {
    
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    private var coinList: [Coin] = []
    private var filteredList: [Coin] = [] {
        didSet {
            reloadSubject.send(())
        }
    }
    
    private var reloadSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    private var currentlyFiltering: Bool = false
    
    var reloadPublisher: AnyPublisher<Void, Never> {
        reloadSubject.eraseToAnyPublisher()
    }
    
    func loadList() {
        RequestManager.shared
            .getCoinList()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    //manage error
                    break
                default:
                    //connection terminated
                    break
                }
            } receiveValue: { [weak self] response in
                guard let coins = response else { return }
                self?.coinList = coins
                self?.filteredList = coins
            }
            .store(in: &bag)
    }
    
    func filter(with searchKey: String) {
        guard !currentlyFiltering else { return }
        currentlyFiltering = true
        filteredList = searchKey.isEmpty ? coinList : coinList.filter({
            $0.searchTerm.contains(searchKey.lowercased())
        })
        currentlyFiltering = false
    }
    
    func getCoin(forIndex index: Int) -> Coin {
        return filteredList[index]
    }
}

extension HomeViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinSimpleCell.reuseIdentifier) ?? UITableViewCell()
        
        if let currentCell = cell as? CoinSimpleCell {
            let coin: CoinSimpleCellModel = filteredList[indexPath.row]
            currentCell.configure(with: coin)
        }
        
        return cell
    }
}
