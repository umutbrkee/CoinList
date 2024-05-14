//
//  CoinsViewModel.swift
//  CoinList
//
//  Created by Umut on 12.05.2024.
//

import Foundation

protocol CoinsViewModelProtocol {
    func load()
    var delegate: CoinsViewModelDelegate? { get set }
    var numberOfCoins: Int { get }
    var coins: [Coin] { get }
    var sortedCoins: [Coin] { get }
    func fetchCoins()
    func sortCoins(by sortingType: SortingType)
}

protocol CoinsViewModelDelegate: AnyObject {
    func didFetchCoins()
    func sortCoins()
}

final class CoinsViewModel {
    weak var delegate: CoinsViewModelDelegate?
    private var webservice: WebserviceProtocol
    private var coins = [Coin]()
    private var sortedCoins = [Coin]()
    
    init(webservice: WebserviceProtocol) {
        self.webservice = webservice
    }
    
    func load(){
        fetchCoins()
    }
    func fetchCoins() {
        let url = URL(string: "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins")!
        webservice.getCoins(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let coins):
                self.coins = coins
                self.sortedCoins = coins // Initially, sortedCoins will be the same as coins
                DispatchQueue.main.async {
                    self.delegate?.didFetchCoins()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sortCoins(by sortingType: SortingType) {
        switch sortingType {
        case .byName:
            coins.sort { $0.name < $1.name }
        case .byPrice:
            coins.sort { Float($0.price)! > Float($1.price)! }
        case .byDate:
            coins.sort { $0.listedAt.toDate() < $1.listedAt.toDate() }
        case .byRank: // Yeni durum
            coins.sort { $0.rank < $1.rank }
        case .ascending:
            break
        case .descending:
            break
        }
        sortedCoins = coins
        delegate?.sortCoins()
    }
    
    func search(text: String) {
            if text.isEmpty {
                sortedCoins = coins
            } else {
                sortedCoins = coins.filter { $0.name.lowercased().contains(text.lowercased()) || $0.symbol.lowercased().contains(text.lowercased()) }
            }
            delegate?.sortCoins()
        }
    
    func coin(at index: Int) -> Coin {
        return sortedCoins[index]
    }
    
    var numberOfCoins: Int {
        return sortedCoins.count
    }
    
}

extension Int {
    func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
