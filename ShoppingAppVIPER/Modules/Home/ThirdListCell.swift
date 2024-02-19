//
//  ThirdListCell.swift
//
//  Created by Asya Atpulat on 25.10.2023.
//

import UIKit

class ThirdListCell: UICollectionViewCell {
    
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = String(describing: ThirdListCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellAppearence()
    }
    
    func configureCellAppearence() {
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 0).cgPath
        layer.shadowColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 0.12).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.white.cgColor
    }
    
    func configure(with list: List) {
        titleLabel.text = list.description
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = false
        listImageView.downloaded(from: URL(string: list.imageUrl ?? "")!)
        listImageView.contentMode = .scaleAspectFill
        listImageView.layer.cornerRadius = 3.0
        priceLabel.text = String(format: "%.2f", list.price?.value ?? 0.0) + "$US"
    }
}
