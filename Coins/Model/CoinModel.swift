//
//  CoinModel.swift
//  Coins
//
//  Created by HabilCangir on 7.08.2023.
//

import Foundation

struct CoinModel{
    let time, assetIDBase, assetIDQuote: String?
    let rate: Double?
    
    var strRate: String? {
        return String(format: "%.2f", rate ?? .zero)
    }
}
