//
//  ConViewModel.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import Foundation
import Combine

class CoinViewModel: NSObject {
    
    private var coin: Coin?
    private var price: PriceListResponse?
    
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetchPrices() {
        guard let coin = coin,
              let id = coin.id else {
            return
        }
        
        RequestManager.shared
            .getCoinDetails(forCoinWith: id).sink { completion in
                switch completion {
                case .failure(let error):
                    break
                default:
                    break
                }
            } receiveValue: { [weak self] in
                guard let self = self else { return }
                self.price = $0
            }.store(in: &bag)
    }
}
