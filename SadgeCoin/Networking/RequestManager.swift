//
//  RequestManager.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import Foundation
import Combine

class RequestManager {
    
    private let session: URLSession = URLSession.shared
    
    enum Endpoint {
        case coinList
        case coinDetails(String)
        
        var value: String {
            switch self {
            case .coinList:
                return "/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h"
            case .coinDetails(let id):
                return "/coins/" + id +  "/market_chart?vs_currency=usd&days=1&interval=hourly"
            }
        }
        
        var url: URL? {
            let base: String = "https://api.coingecko.com/api/v3"
            let urlString: String = base + self.value
            return URL(string: urlString)
        }
    }
    
    enum CoinError: Error {
        case map
        case empty
        case unknown
        case badUrl
    }
    
    static let shared: RequestManager = RequestManager()
    
    func getCoinList() -> AnyPublisher<CoinListResponse?, CoinError> {
        
        let subject: PassthroughSubject<CoinListResponse?, CoinError> = PassthroughSubject<CoinListResponse?, CoinError>()
        
        guard let url = Endpoint.coinList.url else {
            subject.send(completion: .failure(.badUrl))
            return subject.eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                subject.send(completion: .failure(.unknown))
                return
            }
            guard let data = data else {
                subject.send(completion: .failure(.empty))
                return
            }

            let decoder = JSONDecoder()
            let recievedData: CoinListResponse? = try? decoder.decode(CoinListResponse.self, from: data)
            
            guard let coinResponse = recievedData else {
                subject.send(completion: .failure(.map))
                return
            }
            
            subject.send(coinResponse)
        }.resume()
        
        return subject.eraseToAnyPublisher()
    }
    
    func getCoinDetails(forCoinWith id: String) -> AnyPublisher<PriceListResponse?, CoinError> {
        
        let subject: PassthroughSubject<PriceListResponse?, CoinError> = PassthroughSubject<PriceListResponse?, CoinError>()
        
        guard let url = Endpoint.coinDetails(id).url else {
            subject.send(completion: .failure(.badUrl))
            return subject.eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                subject.send(completion: .failure(.unknown))
                return
            }
            guard let data = data else {
                subject.send(completion: .failure(.empty))
                return
            }

            let decoder = JSONDecoder()
            let recievedData: PriceListResponse? = try? decoder.decode(PriceListResponse.self, from: data)
            
            guard let priceResponse = recievedData else {
                subject.send(completion: .failure(.map))
                return
            }
            
            subject.send(priceResponse)
        }.resume()
        
        return subject.eraseToAnyPublisher()
    }
    
}
