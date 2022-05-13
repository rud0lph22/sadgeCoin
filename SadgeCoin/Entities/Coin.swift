//
//  Coin.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import Foundation

class Coin: Codable {
    var id: String?
    var symbol: String?
    var name: String?
    var price: Double?
    var change: Double?
    
    var searchTerm: String {
        (id?.lowercased() ?? "") + (symbol?.lowercased() ?? "") + (name?.lowercased() ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case price = "current_price"
        case change = "price_change_percentage_1h_in_currency"
    }
}

extension Coin: CoinSimpleCellModel {
    var symbolLabelText: String {
        symbol?.uppercased() ?? "RCV"
    }
    
    var nameLabelText: String {
        name ?? "RodoCoin"
    }
    
    var isUp: Bool {
        (change ?? 0.00) > 0.00
    }
    
    var currentPrice: Double {
        price ?? 0
    }
}

protocol Favoritable {
    func addTo(coin: Coin)
    
    func remove(coin: Coin)
}
