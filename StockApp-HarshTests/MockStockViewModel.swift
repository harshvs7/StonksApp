//
//  MockStockViewModel.swift
//  StockApp-HarshTests
//
//  Created by Harshvardhan Sharma on 16/11/24.
//

import Foundation

import XCTest
@testable import StockApp_Harsh

class MockStockViewModel: StockViewModel {
    var shouldAPISucceed = true
    var mockStockDetails: StockDetailResponse?
    
    override func fetchStockHoldings(completion: @escaping (Bool) -> Void) {
        if shouldAPISucceed {
            stockHoldingDetails = mockStockDetails
            completion(true)
        } else {
            completion(false)
        }
    }
    
    override func getCurrentValue() -> Double {
        return 5000.0
    }
    
    override func getTotalInvestment() -> Double {
        return 4500.0
    }
    
    override func getTodayPnL() -> Double {
        return 200.0
    }
    
    override func getTotalPnL() -> Double {
        return 500.0 
    }
    
    override func getStockDetails(index: Int) -> (String, Double, Double, Int) {
        let mockHolding = stockHoldingDetails?.data.userHolding[index]
        return (mockHolding?.symbol ?? "", mockHolding?.ltp ?? 0, mockHolding?.close ?? 0, mockHolding?.quantity ?? 0)
    }
}
