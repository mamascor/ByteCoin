//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Marco Mascorro on 4/5/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation


struct CoinModel {
    
    var coinValue: Double
    var currency: String
    
    
    var coinToString: String {
        return coinValue.withCommas()
    }
    
    
    
    
}


extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}


