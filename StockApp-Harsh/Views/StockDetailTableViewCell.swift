//
//  StockDetailTableViewCell.swift
//  StockApp-Harsh
//
//  Created by Harshvardhan Sharma on 15/11/24.
//

import UIKit

class StockDetailTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: StockDetailTableViewCell.self)
    
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    let ltpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    let profitLossLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(symbolLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(ltpLabel)
        contentView.addSubview(profitLossLabel)
        
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        ltpLabel.translatesAutoresizingMaskIntoConstraints = false
        profitLossLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Symbol label constraints
            symbolLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            symbolLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            // Quantity label constraints
            quantityLabel.leadingAnchor.constraint(equalTo: symbolLabel.leadingAnchor),
            quantityLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 4),
            quantityLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            // LTP label constraints (trailing-aligned)
            ltpLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ltpLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            // P&L label constraints (below LTP, trailing-aligned)
            profitLossLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            profitLossLabel.topAnchor.constraint(equalTo: ltpLabel.bottomAnchor, constant: 4),
            profitLossLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    
    func configure(with symbol: String, ltp: Double, close: Double, netQty: Int) {
        symbolLabel.text = symbol
        quantityLabel.text = "Qty: \(netQty)"
        ltpLabel.text = "LTP: ₹\(ltp)"
        
        let pnl = (close - ltp) * Double(netQty)
        profitLossLabel.text = String(format: "P&L: ₹%.2f", pnl)
        profitLossLabel.textColor = pnl < 0 ? .red : .systemGreen
    }
}
