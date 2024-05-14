//
//  CollectionViewCellViewModel.swift
//  CoinList
//
//  Created by Umut on 13.05.2024.
//

import Foundation
import UIKit

class CoinCellViewModel {
    let symbol: String
    let fullName: String
    let iconURL: String
    let networkService: Webservice
    let price: String
    let btcPrice: String
    let change: String
    
    init(coin: Coin, networkService: Webservice) {
        self.symbol = coin.symbol
        self.fullName = coin.name
        self.iconURL = coin.iconURL
        self.networkService = networkService
        self.price = coin.price
        self.btcPrice = coin.btcPrice
        self.change = coin.change
    }
    
    func percentColor() -> UIColor {
        guard let percentChange = Float(change) else { return .red }
        return percentChange >= 0 ? .green : .red
    }
}
