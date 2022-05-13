//
//  HomeViewModel.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import Foundation
import Combine

class HomeViewModel {
    
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    private var coinList: [Coin] = []
    private var filteredList: [Coin] = [] {
        didSet {
            coinSubject.send(filteredList)
        }
    }
    
    private var coinSubject: PassthroughSubject<[Coin], Never> = PassthroughSubject<[Coin], Never>()
    private var coinPublisher: AnyPublisher<[Coin], Never> {
        return coinSubject.eraseToAnyPublisher()
    }
    
    func loadList() -> AnyPublisher<[Coin], Never> {
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
        
        return coinPublisher
    }
    
    func filter(with searchKey: String) {
        filteredList = coinList.filter({
            $0.searchTerm.contains(searchKey)
        })
    }
}
