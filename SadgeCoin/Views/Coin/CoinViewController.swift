//
//  CoinViewController.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import Foundation
import UIKit
import SwiftChart
import Combine

class CoinViewController: UIViewController {
    
    private var model: CoinViewModel
    
    private var chart: Chart = Chart()
    private var titleLabel: UILabel = UILabel()
    private var subtitleLabel: UILabel = UILabel()
    
    private var priceLabel: UILabel = UILabel()
    private var backButton: UIButton = UIButton(type: .system)
    
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    convenience init() {
        fatalError("Avoid this init since no model is setted")
    }
        
    init(withModel model: CoinViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
            
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setTitle(model.backButtonTitle, for: .normal)
        configureUI()
        bind()
    }
    
    private func bind() {
        model.fetchPrices()
            .sink { [weak self] _ in
                self?.reload()
            }
            .store(in: &bag)
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    private func reload() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.titleLabel.text = self.model.viewTitle
            self.subtitleLabel.text =  self.model.viewSubtitle
            self.priceLabel.text = self.model.viewDescription
            self.chart.add(self.model.chartSiries)
        }
    }
    
    private func configureUI() {
        configureTitle()
        configureBackButton()
        configureSubtitle()
        configurePrice()
        configureChart()
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func configureBackButton() {
        backButton.removeFromSuperview()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
            backButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 8),
            backButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            backButton.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func configureTitle() {
        titleLabel.removeFromSuperview()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
            titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -100),
            titleLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func configureSubtitle() {
        subtitleLabel.removeFromSuperview()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            subtitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -100),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configurePrice() {
        priceLabel.removeFromSuperview()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
            priceLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            priceLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -100),
            priceLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureChart() {
        chart.removeFromSuperview()
        chart.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(chart)
        
        NSLayoutConstraint.activate([
            chart.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            chart.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            chart.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            chart.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8)
        ])
    }
}
