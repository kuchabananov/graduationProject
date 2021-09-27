//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Евгений on 4.09.21.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var user: User?
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
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


extension ViewController: WKNavigationDelegate {
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
            var expiresInInt: Int?
            var userId: String?
            
            for item in responseStringArray {
                let params = item.components(separatedBy: "=")
                if params.first == "access_token" {
                    token = params.last
                } else if params.first == "expires_in"{
                    if let expiresIn = params.last {
                        expiresInInt = Int(expiresIn)
                    }
                } else if params.first == "user_id" {
                    userId = params.last
                }
            }
            guard let token = token, let expiresInInt = expiresInInt, let userId = userId else { return }
            NetworkManager.shared.accessToken = Token(token: token, expiresIn: expiresInInt, userId: userId)
            NetworkManager.shared.getUsers(userId: userId) { [weak self] result in
                switch result {
                case .success(let user):
                    print(user)
                case .failure:
                    print("FAILED")
                }
            }
        }
    }
}
