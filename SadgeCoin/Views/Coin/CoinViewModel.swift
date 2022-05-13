//
//  ConViewModel.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import Foundation
import Combine
import SwiftChart

class CoinViewModel: NSObject {
    
    private var coin: Coin?
    private var price: PriceListResponse?
    
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    private var reloadSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    private var reloadPublish: AnyPublisher<Void, Never> {
        reloadSubject.eraseToAnyPublisher()
    }
    
    var backButtonTitle: String = "Close"
    var viewTitle: String { coin?.symbolLabelText ?? "" }
    var viewSubtitle: String { coin?.nameLabelText ?? "" }
    var viewDescription: String {
        "(" + String(coin?.change ?? 0.00) + ")" + String(coin?.price ?? 0.00)
    }
    
    var chartSiries: ChartSeries {
        guard let prices = price?.pricesAsTouple else { return ChartSeries([0]) }
        return ChartSeries(data: prices)
    }
    
    init(with coin: Coin) {
        self.coin = coin
    }
    
    func fetchPrices() -> AnyPublisher<Void, Never> {
        if let coin = coin,
            let id = coin.id {
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
                    self.reloadSubject.send(())
                }.store(in: &bag)
        }
        
        return reloadPublish
    }
}
