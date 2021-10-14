//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Евгений on 4.09.21.
//

import UIKit

class StartViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.insertSublayer(UIView.setGradietnBackgroundView(view: view), at: 0)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let webVC = WebViewController()
        webVC.delegate = self
        webVC.modalPresentationStyle = .overCurrentContext
        present(webVC, animated: true, completion: nil)
    }
    
}

extension StartViewController: WebViewControllerDelegate {
    
    func webViewDidFinish() {
        guard let userId = NetworkManager.shared.accessToken?.userId else { return }
        let storyboard = UIStoryboard.init(name: "MainMenu", bundle: nil)
        if let mainMenuVC = storyboard.instantiateViewController(identifier: "tabBarController") as? TabBarController {
            mainMenuVC.userId = userId
            navigationController?.pushViewController(mainMenuVC, animated: true)
        }
    }
    
}
