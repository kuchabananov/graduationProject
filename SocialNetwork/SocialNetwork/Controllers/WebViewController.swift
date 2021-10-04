//
//  WebViewController.swift
//  SocialNetwork
//
//  Created by Евгений on 27.09.21.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: AnyObject {
    func webViewDidFinish()
}

class WebViewController: UIViewController {
    
    weak var delegate: WebViewControllerDelegate?
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    func setupWebView() {
        webView = WKWebView(frame: self.view.frame)
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        if let url = URL(string: NetworkManager.shared.urlAuth) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        webView.allowsBackForwardNavigationGestures = true
    }
    
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
        if let response = navigationResponse.response.url?.absoluteString, response.contains("access_token=") {
                var responseString = response
                if let index = responseString.firstIndex(of: "#") {
                    let newIndex = responseString.index(after: index)
                    responseString = String(responseString.suffix(from: newIndex))
                }
                let responseStringArray = responseString.components(separatedBy: "&")
            
            var token: String?
            var userId: String?
            var expiresInDate: Date?
            
            for item in responseStringArray {
                let params = item.components(separatedBy: "=")
                if params.first == "access_token" {
                    token = params.last
                } else if params.first == "expires_in"{
                    if let expiresIn = params.last {
                        if let expiresInInt = Int(expiresIn) {
                            let today = Date()
                            expiresInDate = Calendar.current.date(byAdding: .second, value: expiresInInt, to: today)
                        }
                    }
                } else if params.first == "user_id" {
                    userId = params.last
                }
            }
                        
            guard let token = token, let expiresInDate = expiresInDate, let userId = userId else { return }
            NetworkManager.shared.accessToken = Token(token: token, expiresIn: expiresInDate, userId: userId)
            delegate?.webViewDidFinish()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
