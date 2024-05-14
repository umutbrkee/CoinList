//
//  Colors.swift
//  CoinList
//
//  Created by Umut on 10.05.2024.
//

import UIKit

struct Colors {
    static let controlHighlighted = UIColor(red: 0/255, green: 145/255, blue: 130/255, alpha: 1.0)
    static let controlEnabled = UIColor(red: 0/255, green: 125/255, blue: 110/255, alpha: 1.0)
    static let controlDisabled = UIColor(red: 0/255, green: 105/255, blue: 90/255, alpha: 1.0)
    static let controlTextEnabled = UIColor.white
    static let controlTextDisabled = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
    
    static let positiveGrow = UIColor(red: 148/255, green: 184/255, blue: 108/255, alpha: 1.0)
    static let negativeGrow = UIColor(red: 210/255, green: 80/255, blue: 78/255, alpha: 1.0)
    static let bubbleBackground = UIColor(red: 51/255, green: 55/255, blue: 68/255, alpha: 1.0)
    static let actionButtonBackground = UIColor(red: 51/255, green: 55/255, blue: 68/255, alpha: 1.0)
}

struct Formatter {
    static func formatCost(label: UILabel, value: Double, maximumFractionDigits: Int) {
        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = maximumFractionDigits
        
        let formattedValue = formatter.string(from: NSNumber(value: value)) ?? "\(value)"
        label.text = formattedValue
    }
}
