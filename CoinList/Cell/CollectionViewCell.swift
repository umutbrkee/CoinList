//
//  CollectionViewCell.swift
//  CoinList
//
//  Created by Umut on 10.05.2024.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var btcPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbol: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with coin: Coin) {
        nameLabel.text = coin.name
        symbol.text = coin.symbol
        priceLabel.text = coin.price
        btcPriceLabel.text = coin.btcPrice
        percentageLabel.text = coin.change
        let modifiedURL = coin.iconURL.replacingLast3Characters(with: "png")
        let url = URL(string: modifiedURL)
        image.kf.setImage(with: url)
    }

}
extension String {
    func replacingLast3Characters(with newEnding: String) -> String {
        guard self.count >= 3 else { return self }
        let index = self.index(self.endIndex, offsetBy: -3)
        let start = self[..<index]
        return start + newEnding
    }
}

