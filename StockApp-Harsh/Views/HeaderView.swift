//
//  HeaderView.swift
//  StockApp-Harsh
//
//  Created by Harshvardhan Sharma on 15/11/24.
//

import UIKit

class HeaderView: UIView {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "navyBlue") ?? .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        backgroundView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView.addSubview(profileIconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            profileIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileIconImageView.widthAnchor.constraint(equalToConstant: 24),
            profileIconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: profileIconImageView.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            searchButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 24),
            searchButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}
