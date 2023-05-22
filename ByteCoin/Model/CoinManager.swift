//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailError(_ error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "27B00BB2-384B-4F26-A64F-5F41E847D1AA"
    
    func getCoinPrice(currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(url)
        performRequest(urlString: url)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString ) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailError(error!)
                    return
                }
                
                if let safeData = data {
                    if let coin = parseJSON(safeData) {
                        self.delegate?.didUpdateCoin(self, coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data ) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            
            let cData = CoinModel(coinValue: rate, currency: currency)
            print(cData.coinToString, cData.currency)
            
            return cData
            
            
        }
        catch {
            return nil
        }
        
    }
    
    
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
}
