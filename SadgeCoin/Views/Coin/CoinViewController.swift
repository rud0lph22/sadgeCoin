//
//  CoinViewController.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import Foundation
import UIKit
import SwiftChart

class CoinViewController: UIViewController {
    
    private var model: CoinViewModel
    
    private var chart: Chart = Chart()
    private var titleLabel: UILabel = UILabel()
    private var subtitleLabel: UILabel = UILabel()
    
    private var priceLabel: UILabel = UILabel()
    private var percentageLabel: UILabel = UILabel()
    private var backButton: UIButton = UIButton()
    
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
    }
}
