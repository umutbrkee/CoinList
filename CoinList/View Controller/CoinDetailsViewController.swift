import UIKit

class CoinDetailsViewController: UIViewController {
    @IBOutlet weak var dateListedLabel: UILabel!
    @IBOutlet weak var lowestPrice: UILabel!
    @IBOutlet weak var highestPrice: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var btcLabel: UILabel!
    @IBOutlet weak var sparklineView: UIView! // UIView ekleyin
    
    var coin: Coin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let coin = coin {
            nameLabel.text = "\(coin.name) Rank #\(coin.rank) "
            usdLabel.text = "$\(coin.price)"
            btcLabel.text = "\(coin.btcPrice) BTC"
            
            // Format date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let formattedDate = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(coin.listedAt)))

            dateListedLabel.text = "Listed at: \(formattedDate)"
            
            if let lowest = coin.sparkline.min(),
               let highest = coin.sparkline.max() {
                lowestPrice.text = "$\(lowest)"
                highestPrice.text = "$\(highest)"
            } else {
                lowestPrice.text = "N/A"
                highestPrice.text = "N/A"
            }
            
            // Create and add sparkline view
            let sparklineFrame = CGRect(x: 0, y: 0, width: sparklineView.frame.width, height: sparklineView.frame.height)
            let sparkline = createSparkline(with: sparklineFrame, sparklineData: coin.sparkline)
            sparklineView.addSubview(sparkline)
        }
    }
    
    func createSparkline(with frame: CGRect, sparklineData: [String]) -> UIView {
        let sparklineView = UIView(frame: frame)
        var previousPoint: CGPoint?
        let minValue = sparklineData.min() ?? "0"
        let maxValue = sparklineData.max() ?? "0"
        let range = CGFloat(Double(maxValue)! - Double(minValue)!)
        let valuePerPixel = frame.height / range
        
        for (index, valueString) in sparklineData.enumerated() {
            guard let value = Double(valueString) else { continue }
            let y = frame.height - CGFloat(value - Double(minValue)!) * valuePerPixel
            let x = CGFloat(index) / CGFloat(sparklineData.count - 1) * frame.width
            
            let point = CGPoint(x: x, y: y)
            
            if let prev = previousPoint {
                let path = UIBezierPath()
                path.move(to: prev)
                path.addLine(to: point)
                
                let lineLayer = CAShapeLayer()
                lineLayer.path = path.cgPath
                lineLayer.strokeColor = UIColor.blue.cgColor
                lineLayer.lineWidth = 1.0
                sparklineView.layer.addSublayer(lineLayer)
            }
            
            previousPoint = point
        }
        
        return sparklineView
    }
}
