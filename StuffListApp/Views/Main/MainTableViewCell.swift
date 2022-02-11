//
//  MainTableViewCell.swift
//  StuffListApp
//
//  Created by Glynvile Satago on 2/9/22.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var discountedPrice: UILabel!
    
    @IBOutlet var imgSpoons: [UIImageView]!
    
    var foodViewModel: FoodViewModel? {
        willSet {
            if let value = newValue {
                self.lblTitle.text = value.food.name
                self.imgView?.image = UIImage(named: value.food.imageUrl)
                
                
                if value.food.discountedPrice > 0.0 {
                    let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: " PHP\(value.food.price) ")
                        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
                    self.lblPrice.attributedText = attributeString
                    
                    self.discountedPrice.text = " PHP\(value.food.discountedPrice) "
                }
                else {
                    self.lblPrice.attributedText = NSMutableAttributedString(string: " PHP\(value.food.price) ")
                    self.discountedPrice.text = ""
                }
                
                // Set the star
                for i in 0..<self.imgSpoons.count {
                    let img = self.imgSpoons[i]
                    if i < (value.food.star) {
                        img.image = UIImage(named: "spoonicon")
                    }
                    else {
                        img.image = nil
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.layer.masksToBounds = true
    }
}
