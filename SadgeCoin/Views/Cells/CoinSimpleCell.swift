//
//  CoinSimpleCell.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import UIKit

protocol CoinSimpleCellModel {
    var symbolLabelText: String { get }
    var nameLabelText: String { get }
}

class CoinSimpleCell: UITableViewCell {
    private var symbolLabel: UILabel = UILabel()
    private var nameLabel: UILabel = UILabel()
    
    func configure(with model: CoinSimpleCellModel) {
        configureSymbol()
        configureName()
        nameLabel.text = model.nameLabelText
        symbolLabel.text = model.symbolLabelText
    }
    
    private func configureSymbol() {
        symbolLabel.removeFromSuperview()
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(symbolLabel)
        
        NSLayoutConstraint.activate([
            symbolLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            symbolLabel.topAnchor.constraint(equalTo: self.topAnchor),
            symbolLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            symbolLabel.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func configureName() {
        nameLabel.removeFromSuperview()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: self.symbolLabel.rightAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        ])
    }
}
