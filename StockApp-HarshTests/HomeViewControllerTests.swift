//
//  HomeViewControllerTests.swift
//  StockApp-HarshTests
//
//  Created by Harshvardhan Sharma on 16/11/24.
//

import UIKit
import XCTest

class HomeViewControllerTests: XCTestCase {
    
    var sut: HomeViewController!
    var mockViewModel: MockStockViewModel!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        sut = HomeViewController()
        mockViewModel = MockStockViewModel()
        sut.viewModel = mockViewModel
        window.addSubview(sut.view)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        window = nil
        sut = nil
        mockViewModel = nil
        super.tearDown()
    }
    
    func testAPI_Success() {
        // Given
        mockViewModel.shouldAPISucceed = true
        mockViewModel.mockStockDetails = StockDetailResponse(data: StockDetails(userHolding: [
            UserHolding(symbol: "MAHABANK", quantity: 990, ltp: 38.05, avgPrice: 35, close: 40),
            UserHolding(symbol: "ICICI", quantity: 100, ltp: 118.25, avgPrice: 110, close: 105)
        ]))
        
        // When
        sut.apiCall()
        
        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.sut.stockTableView.numberOfRows(inSection: 0), 2, "TableView row count should match the number of holdings.")
            XCTAssertFalse(self.sut.profitLossView.isHidden, "ProfitLossView should be visible after API success.")
            XCTAssertEqual(self.sut.viewModel.getCurrentValue(), 5000.0, "Current value should match the mock value.")
            XCTAssertEqual(self.sut.viewModel.getTotalInvestment(), 4500.0, "Total investment should match the mock value.")
        }
    }
    
    func testAPI_Failure() {
        // Given
        mockViewModel.shouldAPISucceed = false
        
        // When
        sut.apiCall()
        
        // Then
        DispatchQueue.main.async {
            XCTAssertTrue(self.sut.profitLossView.isHidden, "ProfitLossView should remain hidden when API fails.")
            XCTAssertEqual(self.sut.stockTableView.numberOfRows(inSection: 0), 0, "TableView should have no rows when API fails.")
        }
    }
    
    func testTableView_CellConfiguration() {
        // Given
        mockViewModel.shouldAPISucceed = true
        mockViewModel.mockStockDetails = StockDetailResponse(data: StockDetails(userHolding: [
            UserHolding(symbol: "MAHABANK", quantity: 990, ltp: 38.05, avgPrice: 35, close: 40),
            UserHolding(symbol: "ICICI", quantity: 100, ltp: 118.25, avgPrice: 110, close: 105)
        ]))
        sut.apiCall()
        
        // When
        let cell = sut.tableView(sut.stockTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? StockDetailTableViewCell
        
        // Then
        XCTAssertNotNil(cell, "TableView cell should not be nil.")
        XCTAssertEqual(cell?.symbolLabel.text, "MAHABANK", "The cell symbol label should match the holding symbol.")
        XCTAssertEqual(cell?.ltpLabel.text, "₹38.05", "The cell LTP label should match the holding LTP.")
    }
}
