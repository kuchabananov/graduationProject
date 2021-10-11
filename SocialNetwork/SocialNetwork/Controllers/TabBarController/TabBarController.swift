//
//  TabBarController.swift
//  SocialNetwork
//
//  Created by Евгений on 5.10.21.
//

import UIKit

class TabBarController: UITabBarController {
    
    var homeButton = UIButton()
    
    var userId: String? {
        didSet {
            guard let userId = userId else { return }
            profileController?.reloadPage(userId: userId)
            friendsController?.reloadPage(userId: userId)
            if userId != NetworkManager.shared.accessToken?.userId {
                homeButton.isHidden = false
            } else {
                homeButton.isHidden = true
            }
        }
    }
    
    var profileController: ProfileViewController? {
        return viewControllers?[0] as? ProfileViewController
    }
    var friendsController: FriendsViewController? {
        return viewControllers?[1] as? FriendsViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addCenterButton()
    }
    
    
    private func addCenterButton() {
        homeButton = UIButton(type: .custom)
        let square = self.tabBar.frame.size.height / 2
        homeButton.frame = CGRect(x: (self.view.frame.width / 2) - (square / 2), y: (self.tabBar.frame.origin.y) + 8, width: square, height: square)
        homeButton.setBackgroundImage(UIImage(named: "gohome"), for: .normal)
        
        self.view.addSubview(homeButton)
        self.view.bringSubviewToFront(homeButton)
        
        homeButton.addTarget(self, action: #selector(centerButtonAction(sender:)), for: .touchUpInside)
        homeButton.isHidden = true
        homeButton.layoutIfNeeded()
    }
    
    @objc private func centerButtonAction(sender: UIButton) {
        userId = NetworkManager.shared.accessToken?.userId
        selectedIndex = 0
    }


    // MARK: - Navigation

//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        super.tabBar(tabBar, didSelect: item)
//        let profVC = viewControllers?[0] as? ProfileViewController
//    }

    

    
}
