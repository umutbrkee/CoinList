//
//  WebService.swift
//  CoinList
//
//  Created by Umut on 11.05.2024.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class Webservice {
    
    func getCoins(url: URL, completion: @escaping (Result<[Coin], Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Welcome.self, from: data)
                completion(.success(decodedData.data.coins))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    
}

