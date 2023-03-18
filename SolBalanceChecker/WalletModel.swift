//
//  WalletModel.swift
//  SolBalanceChecker
//
//  Created by Степан Фоминцев on 18.03.2023.
//

import Foundation

struct Wallet: Codable {
    let success: Bool
    let message: String
    let result: Result
}

struct Result: Codable {
    let sol_balance: Double
    let num_nfts: Int
}
