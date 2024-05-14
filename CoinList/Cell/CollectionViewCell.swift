//
//  CollectionViewCell.swift
//  CoinList
//
//  Created by Umut on 10.05.2024.
//

import UIKit
import Kingfisher

class CoinCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinFullName: UILabel!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    
    // MARK: - Properties
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureShape()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        coinPriceLabel.text = ""
        coinImage.image = nil
    }
    
    // MARK: - Configure
    
    private func configureShape() {
        self.contentView.layer.cornerRadius = 12.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 12.0
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    public func configure(using viewModel: CoinCellViewModel) {
        coinFullName.text = viewModel.fullName
        coinName.text = "(\(viewModel.symbol))"
        coinPriceLabel.text = "$\(viewModel.price)"
        percentChangeLabel.text = "\(viewModel.change)%"
        percentChangeLabel.textColor = viewModel.percentColor()
        
        let modifiedURL = viewModel.iconURL.replacingLast3Characters(with: "png")
        let url = URL(string: modifiedURL)
        coinImage.kf.setImage(with: url)
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

