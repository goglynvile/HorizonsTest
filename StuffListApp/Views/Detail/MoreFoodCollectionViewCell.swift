//
//  MoreFoodCollectionViewCell.swift
//  StuffListApp
//
//  Created by Glynvile Satago on 2/10/22.
//

import UIKit

class MoreFoodCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.layer.masksToBounds = true
    }
}
