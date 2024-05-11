//
//  CoinsViewController.swift
//  CoinList
//
//  Created by Umut on 8.05.2024.
//
import UIKit

enum SortingType {
    case ascending
    case descending
}

class CoinsViewController: UIViewController {
    
    @IBOutlet weak var sortingSegmentControl: UISegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var favoritesSegmentControl: UISegmentedControl!
    @IBOutlet weak var coinsCollectionView: UICollectionView!
    var coins = [Coin]()
    var sortedCoins = [Coin]() // Sorted array to preserve the original data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering the cell
        coinsCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        sortingSegmentControl.addTarget(self, action: #selector(sortingSegmentValueChanged(_:)), for: .valueChanged)
            
        // Default sorting type (descending)
        sortingSegmentControl.selectedSegmentIndex = 1
        
        // Fetching coins
        let url = URL(string: "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins")!
        Webservice().getCoins(url: url) { (result) in
            switch result {
            case .success(let coins):
                self.coins = coins
                print(coins[0].price)
                self.sortedCoins = coins // Initially, sortedCoins will be the same as coins
                DispatchQueue.main.async {
                    self.coinsCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        

    }
    
    @objc func sortingSegmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sortCoins(by: .ascending)
        } else {
            sortCoins(by: .descending)
        }
    }
    
    func sortCoins(by sortingType: SortingType) {
        switch sortingType {
        case .ascending:
            sortedCoins.sort { Float($0.price)! < Float($1.price)! }
        case .descending:
            sortedCoins.sort { Float($0.price)! > Float($1.price)! }
        }
        coinsCollectionView.reloadData()
    }

}

extension CoinsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedCoins.count // Use sortedCoins for collection view data source
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = coinsCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(with: sortedCoins[indexPath.row]) // Use sortedCoins for configuring cell
        return cell
    }
}

extension CoinsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCoin = sortedCoins[indexPath.row]
        
        // Hedef view controller'ı oluşturun
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Eğer farklı bir storyboard kullanıyorsanız, ismini ona göre güncelleyin
        guard let coinDetailVC = storyboard.instantiateViewController(withIdentifier: "CoinDetailsViewController") as? CoinDetailsViewController else {
            return
        }
        
        // Seçilen coin'i aktarın
        coinDetailVC.coin = selectedCoin
        
        // Geçiş işlemini gerçekleştirin
        present(coinDetailVC, animated: true, completion: nil)
    }
}

