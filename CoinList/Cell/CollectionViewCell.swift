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
        // Arka plan rengini belirle (isteğe bağlı)
                
                // Kenar boşluklarını belirle (isteğe bağlı)
                contentView.layer.cornerRadius = 8
                contentView.layer.borderWidth = 1
                contentView.layer.borderColor = UIColor.lightGray.cgColor
                
                // Hücrenin tam oturması için kenar boşluklarını belirle (isteğe bağlı)
                contentView.clipsToBounds = true
        
    }
    
    func configure(with coin: Coin) {
        nameLabel.text = coin.name
        symbol.text = coin.symbol
        
        if let priceValue = Double(coin.price) {
            let priceFormatted = String(format: "$%.2f", priceValue)
            priceLabel.text = priceFormatted
        } else {
            priceLabel.text = "$\(coin.price)"
        }
        
        btcPriceLabel.text = "\(coin.btcPrice) USD"
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

