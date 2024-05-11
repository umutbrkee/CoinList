//
//  CoinsViewController.swift
//  CoinList
//
//  Created by Umut on 8.05.2024.
//

import UIKit

class CoinsViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var favoritesSegmentControl: UISegmentedControl!
    @IBOutlet weak var coinsCollectionView: UICollectionView!
    var coins = [Coin]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinsCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        let url = URL(string: "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins")!
        Webservice().getCoins(url: url) { (result) in
            switch result {
            case .success(let coins):
                self.coins = coins
                print(coins[1].name)
                DispatchQueue.main.async {
                    self.coinsCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        print(coins.count)
        coinsCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CoinsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = coinsCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(with: coins[indexPath.row])
        return cell
    }
    
    
}
