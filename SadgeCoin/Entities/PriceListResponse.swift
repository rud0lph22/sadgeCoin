//
//  PriceListResponse.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import Foundation

struct PriceListResponse: Codable {
    var prices: [[Double]] = []
    var marketCaps: [[Double]] = []
    var volumes: [[Double]] = []
    
    enum CodingKeys: String, CodingKey {
        case prices
        case marketCaps = "market_caps"
        case volumes = "total_volumes"
    }
    
    func updatePrices(for coin: Coin) {
        coin.pricesArray = prices
    }
}
