//
//  ProfitLossView.swift
//  StockApp-Harsh
//
//  Created by Harshvardhan Sharma on 15/11/24.
//

import UIKit

class ProfitLossView: UIView {
    
    private var isExpanded = false
    private var heightConstraint: NSLayoutConstraint!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profit & Loss"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentValueLabel: ProfitLossDetailLabel = {
        let label = ProfitLossDetailLabel(title: "Current value")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalInvestmentLabel: ProfitLossDetailLabel = {
        let label = ProfitLossDetailLabel(title: "Total investment")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let todaysProfitLossLabel: ProfitLossDetailLabel = {
        let label = ProfitLossDetailLabel(title: "Today's Profit & Loss")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profitLossValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .gray
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Helper Functions
extension ProfitLossView {
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
        
        addSubview(titleLabel)
        addSubview(profitLossValueLabel)
        addSubview(toggleButton)
        addSubview(separatorView)
        
        labelStackView.addArrangedSubview(currentValueLabel)
        labelStackView.addArrangedSubview(totalInvestmentLabel)
        labelStackView.addArrangedSubview(todaysProfitLossLabel)
        
        labelStackView.isHidden = true
        
        addSubview(labelStackView)
        heightConstraint = heightAnchor.constraint(equalToConstant: 100)
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            
            toggleButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            toggleButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            profitLossValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profitLossValueLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            labelStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8),
            labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    func configureView() {
        isExpanded.toggle()
        labelStackView.isHidden = !isExpanded
        heightConstraint.constant = isExpanded ? 200 : 100
        
        UIView.animate(withDuration: 0.3) {
            let image = self.isExpanded ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up")
            self.toggleButton.setImage(image, for: .normal)
            self.superview?.layoutIfNeeded()
        }
    }
    
    func updateValue(currentValue: Double, totalInvestment: Double, todayProfitLoss: Double, totalProfitLoss: Double) {
        if totalProfitLoss < 0 {
            profitLossValueLabel.text = "-₹\(String(format: "%.2f", abs(totalProfitLoss)))"
            profitLossValueLabel.textColor = .red
        } else {
            profitLossValueLabel.text = "₹\(String(format: "%.2f", abs(totalProfitLoss)))"
        }
        currentValueLabel.updateValueLabel(value: currentValue)
        totalInvestmentLabel.updateValueLabel(value: totalInvestment)
        todaysProfitLossLabel.updateValueLabel(value: todayProfitLoss)
    }
}


class ProfitLossDetailLabel: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func updateValueLabel(value: Double) {
        if value < 0 {
            valueLabel.textColor = .systemRed
            valueLabel.text = "-₹\(String(format: "%.2f", abs(value)))"
        } else {
            valueLabel.text = "₹\(String(format: "%.2f", abs(value)))"
        }
    }
}
