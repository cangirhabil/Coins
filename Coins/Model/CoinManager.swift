

import Foundation

protocol CoinManagerDelegate{
    func didUpdateCoinPrice(coinManager: CoinManager, coinData: CoinModel)
    func didFailWithError(error: Error?)
}




struct CoinManager{
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "DE070A44-8506-409E-97E2-62DBF0D5C12D"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
     
    func getCoinPrice(for currency: String){
        
    }
    
    func fetchCoinInfo(currency: String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, respone, error) in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let coinData = self.parseJSON(safeData){
                        delegate?.didUpdateCoinPrice(coinManager: self, coinData: coinData)
                    }
                }
            }
            task.resume()
        }else{
            print("aaaa")
        }
    }
    
    func parseJSON(_ data: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let rate = decodedData.rate
            let time = decodedData.time
            let assetIDBase = decodedData.assetIDBase
            let assetIDQuote = decodedData.assetIDQuote
            let coinModel = CoinModel(time: time, assetIDBase: assetIDBase, assetIDQuote: assetIDQuote, rate: rate)
            return coinModel
            
        }catch{
            print(error)
            return nil
        }
        
    }
    
}









