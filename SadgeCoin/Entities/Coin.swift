//
//  Coin.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import Foundation

class Coin: Codable {
    var id: String? = "test1234"
    var symbol: String? = "RCV"
    var name: String? = "RodoCoin"
    var pricesArray: [[Double]] = []
}
