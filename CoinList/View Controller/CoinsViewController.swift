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
    
    var viewModel: CoinsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering the cell
        coinsCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        sortingSegmentControl.addTarget(self, action: #selector(sortingSegmentValueChanged(_:)), for: .valueChanged)
            
        // Default sorting type (descending)
        sortingSegmentControl.selectedSegmentIndex = 1
        
        // ViewModel initialization
        viewModel = CoinsViewModel(webservice: Webservice())
        viewModel.delegate = self
        
        // Fetching coins
        viewModel.load()
    }
    
    @objc func sortingSegmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel.sortCoins(by: .ascending)
        } else {
            viewModel.sortCoins(by: .descending)
        }
    }
}

extension CoinsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCoins
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = coinsCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(with: viewModel.coin(at: indexPath.row))
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
