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
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let webVC = WebViewController()
        webVC.delegate = self
        webVC.modalPresentationStyle = .overCurrentContext
        present(webVC, animated: true, completion: nil)
    }
    

    @IBAction func qwerty(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "MainMenu", bundle: nil)
        let mainMenuVC = storyboard.instantiateViewController(identifier: "tabBarController")
        navigationController?.pushViewController(mainMenuVC, animated: true)
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
