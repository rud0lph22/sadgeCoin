//
//  PriceListResponse.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import Foundation

struct PriceListResponse: Codable {
    var prices: [[Double]] = []
    
    var pricesAsTouple: [(x: Double, y: Double)] {
        var data: [(x: Double, y: Double)] = []
        prices.forEach {
            let item: (x: Double, y: Double) = (x: $0.first ?? 0.00, y: $0.last ?? 0.00)
            data.append(item)
        }
        return data
    }
}
