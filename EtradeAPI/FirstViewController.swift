//
//  FirstViewController.swift
//  EtradeAPI
//
//  Created by Matthew Mohrman on 7/7/17.
//  Copyright © 2017 Matthew Mohrman. All rights reserved.
//

import UIKit
import WebKit

class FirstViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var webViewContainerView: UIView!
    
    private let etradeApi = EtradeApi(
        oauthConsumerKey: "",
        oauthConsumerSecret: ""
    )
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create WKWebView in code, because IB cannot add a WKWebView directly
        self.webView = WKWebView()
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.webViewContainerView.addSubview(webView)
        self.webViewContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-[webView]-|",
                                                                                                options: NSLayoutFormatOptions(rawValue: 0),
                                                                                                metrics: nil,
                                                                                                views: ["webView": webView]))
        self.webViewContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[webView]-|",
                                                                                                options: NSLayoutFormatOptions(rawValue: 0),
                                                                                                metrics: nil,
                                                                                                views: ["webView": webView]))
        self.webView.navigationDelegate = self
        
        etradeApi.getRequestToken() { [unowned self] result in
            do {
                let oauthToken = try result.unwrap()
                self.populateWebView(oauthToken)
            } catch let error {
                debugPrint("Get request token error: \(error.localizedDescription)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - WKNavigationDelegate Methohds
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webView.url?.absoluteString, url == "https://us.etrade.com/e/t/etws/TradingAPICustomerInfo" {
            let javascriptString = "document.getElementsByTagName(\"input\")[0].value;"
            webView.evaluateJavaScript(javascriptString, completionHandler: { [unowned self] (oauthVerifier, error) in
                if let oauthVerifier = oauthVerifier as? String {
                    self.headerLabel.text = "OAuth: Get Access Token"
                    self.webViewContainerView.isHidden = true
                    self.etradeApi.getAccessToken(oauthVerifier: oauthVerifier) { [unowned self] result in
                        do {
                            _ = try result.unwrap()
                            self.headerLabel.text = "OAuth: Authentication Success"
//                            self.etradeApi.revokeAccessToken() { [unowned self] result in
//                                do {
//                                    let success = try result.unwrap()
//                                    print(success)
//                                } catch let error {
//                                    debugPrint("Revoke access token error: \(error.localizedDescription)")
//                                }
//                            }
//                            self.etradeApi.renewAccessToken() { [unowned self] result in
//                                do {
//                                    let success = try result.unwrap()
//                                    if success {
//                                        self.etradeApi.getQuote(symbols: ["GOOG", "AAPL"]) { result in
//                                            do {
//                                                let quotes = try result.unwrap()
//                                                print(quotes)
//                                            } catch let error {
//                                                debugPrint("Renew access token error: \(error.localizedDescription)")
//                                            }
//                                        }
//                                    }
//                                } catch let error {
//                                    debugPrint("Renew access token error: \(error.localizedDescription)")
//                                }
//                            }
//                            self.etradeApi.getQuote(symbols: ["GOOG", "AAPL"]) { result in
//                                do {
//                                    let quotes = try result.unwrap()
//                                    print(quotes)
//                                } catch let error {
//                                    debugPrint("Get quote error: \(error.localizedDescription)")
//                                }
//                            }
//                            self.etradeApi.getProduct(company: "Cisco", securityType: .equity ) { result in
//                                do {
//                                    let products = try result.unwrap()
//                                    print(products)
//                                } catch let error {
//                                    debugPrint("Get product error: \(error.localizedDescription)")
//                                }
//                            }
//                            self.etradeApi.getOptionExpireDates(underlier: "IBM") { result in
//                                do {
//                                    let expireDates = try result.unwrap()
//                                    print(expireDates)
//                                } catch let error {
//                                    debugPrint("Get option expire dates error: \(error.localizedDescription)")
//                                }
//                            }
//                            self.etradeApi.getRateLimitsStatus(module: .market) { result in
//                                do {
//                                    let rateLimitStatus = try result.unwrap()
//                                    print(rateLimitStatus)
//                                } catch let error {
//                                    debugPrint("Get rate limit status error: \(error.localizedDescription)")
//                                }
//                            }
//                            self.etradeApi.getOptionChains(optionChainType: .callPut, expirationMonth: 8, expirationYear: 2017, underlier: "GOOG") { result in
//                                do {
//                                    let optionChain = try result.unwrap()
//                                    print(optionChain)
//                                } catch let error {
//                                    debugPrint("Get option chains error: \(error.localizedDescription)")
//                                }
//                            }
//                            self.etradeApi.getAccountList() { result in
//                                do {
//                                    let accounts = try result.unwrap()
//                                    print(accounts)
//                                } catch let error {
//                                    debugPrint("Get account list error: \(error.localizedDescription)")
//                                }
//                            }
                            self.etradeApi.getAccountBalance(accountId: 25) { result in
                                do {
                                    let account = try result.unwrap()
                                    print(account)
                                } catch let error {
                                    debugPrint("Get account balance error: \(error.localizedDescription)")
                                }
                            }
                        } catch let error {
                            debugPrint("Get access token error: \(error.localizedDescription)")
                        }
                    }
                }
            })
        }
    }
    
    // MARK: - Private Methods
    private func populateWebView(_ oauthToken: String) {
        headerLabel.text = "OAuth: Authorize Application"
        let urlString = self.etradeApi.getAuthorizeUrlString(oauthToken)
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            webViewContainerView.isHidden = false
            _ = self.webView.load(urlRequest)
        }
    }
}

