//
//  CoinSimpleCell.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import UIKit
import Combine

protocol CoinSimpleCellModel {
    var symbolLabelText: String { get }
    var nameLabelText: String { get }
    var isUp: Bool { get }
    var currentPrice: Double { get }
}

class CoinSimpleCell: UITableViewCell {
    private var symbolLabel: UILabel = UILabel()
    private var nameLabel: UILabel = UILabel()
    private var priceLabel: UILabel = UILabel()
    private var favButton: UIButton = UIButton(type: .system)
    private var buttonWasTappedSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    var buttonWasTappedPublisher: AnyPublisher<Void, Never> {
        imBiengListeningTo = true
        return buttonWasTappedSubject.eraseToAnyPublisher()
    }

    var imBiengListeningTo: Bool = false
    
    @objc func buttonWasTapped() {
        buttonWasTappedSubject.send(())
    }
    
    func configure(with model: CoinSimpleCellModel) {
        configureSymbol()
        configurePrice()
        configureName()
        setStyle(withModel: model)
        nameLabel.text = model.nameLabelText
        symbolLabel.text = model.symbolLabelText
        priceLabel.text = String(model.currentPrice)
    }
    
    private func configureSymbol() {
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(symbolLabel)
        
        NSLayoutConstraint.activate([
            symbolLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            symbolLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            symbolLabel.heightAnchor.constraint(equalToConstant: 16),
            symbolLabel.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func configureName() {
        nameLabel.removeFromSuperview()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: self.symbolLabel.bottomAnchor, constant: 4),
            nameLabel.rightAnchor.constraint(equalTo: self.favButton.leftAnchor, constant: 4),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4)
        ])
    }
    
    private func configurePrice() {
        favButton.removeFromSuperview()
        favButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(favButton)
        
        NSLayoutConstraint.activate([
            favButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            favButton.widthAnchor.constraint(equalToConstant: 100),
            favButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            favButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4)
        ])
        favButton.setTitle("agregar", for: .normal)
        favButton.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
    }
    
    private func setStyle(withModel model: CoinSimpleCellModel) {
        if model.isUp {
            self.backgroundColor = .green.withAlphaComponent(0.1)
        } else {
            self.backgroundColor = .red.withAlphaComponent(0.1)
        }
    }
}
