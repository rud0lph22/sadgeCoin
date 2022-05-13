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
    
    var searchTerm: String {
        (id ?? "") + (symbol ?? "") + (name ?? "")
    }
}

extension Coin: CoinSimpleCellModel {
    var symbolLabelText: String {
        symbol ?? "RCV"
    }
    
    var nameLabelText: String {
        name ?? "RodoCoin"
    }
}
