//
//  CoinDetailsViewController.swift
//  CoinList
//
//  Created by Umut on 8.05.2024.
//

import UIKit

class CoinDetailsViewController: UIViewController {
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var btcLabel: UILabel!
    
    var coin: Coin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let coin = coin {
            nameLabel.text = coin.name
            usdLabel.text = "$\(coin.price)"
            btcLabel.text = "\(coin.btcPrice) BTC"

        }
    }
}


