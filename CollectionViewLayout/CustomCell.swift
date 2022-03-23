//
//  FirstCustomCollectionViewCell.swift
//  CollectionViewLayout
//
//  Created by Дарья Носова on 21.03.2022.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var textLabel: UILabel!
    
    static let reuseIdentifier = "CustomCell"
    
    func configure(with text: String) {
        textLabel.text = "\(text)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.2
    }
    // Создаем кастомную ячейку из nib-файла
}
