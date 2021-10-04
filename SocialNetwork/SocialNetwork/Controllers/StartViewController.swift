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

}

extension StartViewController: WebViewControllerDelegate {
    func webViewDidFinish() {
        guard let userId = NetworkManager.shared.accessToken?.userId else { return }
        
        let profileVC = ProfileViewController()
        profileVC.userId = userId
        profileVC.modalPresentationStyle = .overCurrentContext
        navigationController?.present(profileVC, animated: true, completion: nil)
        //present(profileVC, animated: true, completion: nil)
        
//        NetworkManager.shared.getUsers(userId: userId) { [weak self] result in
//            switch result {
//            case .success(let user):
//                print(user)
//            case .failure:
//                print("FAILED")
//            }
//        }
    }
}
