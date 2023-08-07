//
//  ViewController.swift
//  Coins
//
//  Created by HabilCangir on 1.08.2023.

import UIKit
class ViewController: UIViewController{
    
    @IBOutlet weak var CurrencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }

}

extension ViewController:CoinManagerDelegate{
    func didUpdateCoinPrice(coinManager: CoinManager, coinData: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coinData.strRate
            self.CurrencyLabel.text = coinData.assetIDQuote
        }
    }
    
    func didFailWithError(error: Error?) {
        debugPrint(error!)
    }
}


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        coinManager.fetchCoinInfo(currency: selectedCurrency)
    }
}
