//
//  ViewController.swift
//  SolBalanceChecker
//
//  Created by Степан Фоминцев on 18.03.2023.
//

// THE APP FOR TEST SOME FUNCTIONS

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var walletAddressLabel: UILabel!
    
    @IBOutlet weak var walletBalanceLabel: UILabel!
    
    @IBOutlet weak var walletNFTsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addWalletPressed() {
        presentAddAlertController(title: "Wallet address", message: nil, style: .alert) { address in
            self.fetchWalletData(address)
        }
    }
    
    private func fetchWalletData(_ wallet: String) {
        let url = URL(string: "https://api.shyft.to/sol/v1/wallet/get_portfolio?network=mainnet-beta&wallet=\(wallet)")!
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("-3iYNcRok7Gm4EMl", forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            
            let walletData = try? JSONDecoder().decode(Wallet.self, from: data)
            guard let walletData else { return }
            DispatchQueue.main.async {
                self.walletAddressLabel.text = wallet
                self.walletBalanceLabel.text = String(walletData.result.sol_balance)
                self.walletNFTsLabel.text = String(walletData.result.num_nfts)
            }
        }.resume()
    }
}
