//
//  CoinsViewController.swift
//  CoinList
//
//  Created by Umut on 10.05.2024.
//

import UIKit

enum SortingType {
    case ascending
    case descending
    case byName
    case byPrice
    case byDate
    case byRank
}


class CoinsViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var sortingSegmentControl: UISegmentedControl!
    @IBOutlet weak var favoritesSegmentControl: UISegmentedControl!
    @IBOutlet weak var coinsCollectionView: UICollectionView!
    
    var viewModel: CoinsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering the cell
        coinsCollectionView.register(UINib(nibName: "CoinCell", bundle: nil), forCellWithReuseIdentifier: "CoinCell")
        
        sortingSegmentControl.addTarget(self, action: #selector(sortingSegmentValueChanged(_:)), for: .valueChanged)
        
        // Default sorting type (descending)
        sortingSegmentControl.selectedSegmentIndex = 1
        
        configureCollectionViewFlowLayout()
        
        // ViewModel initialization
        viewModel = CoinsViewModel(webservice: Webservice())
        viewModel.delegate = self
        
        // Fetching coins
        viewModel.load()
    }
    
    private func configureCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width - 32, height: 70)
        coinsCollectionView.collectionViewLayout = layout
    }
    
    @objc func sortingSegmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.sortCoins(by: .byName)
        case 1:
            viewModel.sortCoins(by: .byPrice)
        case 2:
            viewModel.sortCoins(by: .byDate)
        case 3: // Yeni durum
            viewModel.sortCoins(by: .byRank)
        default:
            break
        }
    }
}
extension CoinsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCoins
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCell", for: indexPath) as! CoinCell
                
                // Coin nesnesini CoinCellViewModel'e dönüştürme
                let coin = viewModel.coin(at: indexPath.row)
                let coinCellViewModel = CoinCellViewModel(coin: coin, networkService: Webservice())
                
                // Dönüştürülen CoinCellViewModel'i kullanarak hücreyi yapılandırma
                cell.configure(using: coinCellViewModel)
                return cell
    }
}

extension CoinsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCoin = viewModel.coin(at: indexPath.row)
        
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

extension CoinsViewController: CoinsViewModelDelegate {
    func didFetchCoins() {
        DispatchQueue.main.async {
            self.coinsCollectionView.reloadData()
        }
    }
    
    func sortCoins() {
        DispatchQueue.main.async {
            self.coinsCollectionView.reloadData()
        }
    }
}

extension CoinsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(text: searchText)
        self.coinsCollectionView.reloadData()
    }
}
