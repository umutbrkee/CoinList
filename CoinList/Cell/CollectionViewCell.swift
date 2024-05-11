//
//  CollectionViewCell.swift
//  CoinList
//
//  Created by Umut on 10.05.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var priceBtcLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbol: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        nameLabel.text = "Bitcoin"
        symbol.text = "BTC"
        priceLabel.text = "1000"
        priceBtcLabel.text = "0.0001"
        percentageLabel.text = "%37m"
    }
}
