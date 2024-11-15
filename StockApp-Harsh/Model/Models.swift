//
//  Models.swift
//  StockApp-Harsh
//
//  Created by Harshvardhan Sharma on 15/11/24.
//

import Foundation

// MARK: - StockDetailResponse
struct StockDetailResponse: Codable {
    let data: StockDetails

    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - StockDetails
struct StockDetails: Codable {
    let userHolding: [UserHolding]

    enum CodingKeys: String, CodingKey {
        case userHolding
    }
}

// MARK: - UserHolding
struct UserHolding: Codable {
    let symbol: String
    let quantity: Int
    let ltp, avgPrice, close: Double

    enum CodingKeys: String, CodingKey {
        case symbol
        case quantity
        case ltp
        case avgPrice
        case close
    }
}
