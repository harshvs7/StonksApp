//
//  HomeViewController.swift
//  StockApp-Harsh
//
//  Created by Harshvardhan Sharma on 15/11/24.
//

import UIKit


class HomeViewController: UIViewController {
    
    var viewModel = StockViewModel()
    
    private let headerView: HeaderView = {
        let view = HeaderView(title: "Portfolio")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stockTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .gray
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    let profitLossView: ProfitLossView = {
        let view = ProfitLossView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

//MARK: - Helper Functions
extension HomeViewController {
    private func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        stockTableView.dataSource = self
        stockTableView.delegate = self
        stockTableView.showsVerticalScrollIndicator = false
        stockTableView.register(StockDetailTableViewCell.self, forCellReuseIdentifier: StockDetailTableViewCell.identifier)
        
        view.addSubview(headerView)
        view.addSubview(stockTableView)
        view.addSubview(activityIndicator)
        view.addSubview(profitLossView)
        
        activityIndicator.startAnimating()
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            profitLossView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profitLossView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profitLossView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stockTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            stockTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stockTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stockTableView.bottomAnchor.constraint(equalTo: profitLossView.topAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        // Add a tap gesture to toggle expand/collapse
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleProfitLossView))
        profitLossView.addGestureRecognizer(tapGesture)
        
        apiCall()
    }
    
    func apiCall() {
        viewModel.fetchStockHoldings { [weak self] success in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if success {
                    self.stockTableView.reloadData()
                    self.profitLossView.updateValue(
                        currentValue: self.viewModel.getCurrentValue(),
                        totalInvestment: self.viewModel.getTotalInvestment(), todayProfitLoss: self.viewModel.getTodayPnL(), totalProfitLoss: self.viewModel.getTotalPnL())
                    self.profitLossView.isHidden = false
                } else {
                    print("Something went wrong")
                }
            }
        }
    }
}

//MARK: @objc func
extension HomeViewController {
    @objc private func toggleProfitLossView() {
        UIView.animate(withDuration: 0.3) {
            self.profitLossView.configureView()
            self.view.layoutIfNeeded()
        }
    }
}

//MARK: UITableView Delegate and Datasource
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stockHoldingDetails?.data.userHolding.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockDetailTableViewCell.identifier, for: indexPath) as? StockDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let stockValues = viewModel.getStockDetails(index: indexPath.row)
        cell.configure(with: stockValues.0, ltp: stockValues.1,  close: stockValues.2, netQty: stockValues.3)
        cell.selectionStyle = .none
        return cell
    }
}
