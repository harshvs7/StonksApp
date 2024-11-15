//
//  ViewModel.swift
//  StockApp-Harsh
//
//  Created by Harshvardhan Sharma on 15/11/24.
//

import Foundation

class StockViewModel {
    
    var stockHoldingDetails: StockDetailResponse?
    var currentValue = 0.0
    var totalInvestment = 0.0
    var totalPnL = 0.0
    var todayPnL = 0.0
    
    func fetchStockHoldings(completion: @escaping(Bool) -> Void) {
        let urlString = "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io"
        
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data,response,error) in
            guard let self = self else {
                completion(false)
                return
            }
            
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let holdingReponse = try JSONDecoder().decode(StockDetailResponse.self, from: data)
                self.stockHoldingDetails = holdingReponse
                completion(true)
            } catch {
                completion(false)
            }
        }.resume()
    }
    
    func getStockDetails(index: Int) -> (String, Double, Double, Int) {
        return ( self.stockHoldingDetails?.data.userHolding[index].symbol ?? "",
                self.stockHoldingDetails?.data.userHolding[index].close ?? 0.0,
                self.stockHoldingDetails?.data.userHolding[index].ltp ?? 0.0,
                self.stockHoldingDetails?.data.userHolding[index].quantity ?? 0)
    }
    
    func getCurrentValue() -> Double {
        currentValue = stockHoldingDetails?.data.userHolding.reduce(0.0) { result, holding in
            result + (holding.ltp * Double(holding.quantity))
        } ?? 0.0
        
        return currentValue
    }
    
    func getTotalInvestment() -> Double {
        totalInvestment = stockHoldingDetails?.data.userHolding.reduce(0.0) { result, holding in
            result + (holding.avgPrice * Double(holding.quantity))
        } ?? 0.0
        
        return totalInvestment
    }
    
    func getTotalPnL() -> Double {
        return currentValue - totalInvestment
    }
    
    func getTodayPnL() -> Double {
        todayPnL = stockHoldingDetails?.data.userHolding.reduce(0.0) { result, holding in
            result + ((holding.close - holding.ltp) * Double(holding.quantity))
        } ?? 0.0
        
        return todayPnL
    }
}
