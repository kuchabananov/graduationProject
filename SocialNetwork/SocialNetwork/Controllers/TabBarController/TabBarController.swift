//
//  TabBarController.swift
//  SocialNetwork
//
//  Created by Евгений on 5.10.21.
//

import UIKit

class TabBarController: UITabBarController {
    
    var userId: String? {
        didSet {
            guard let userId = userId else { return }
            profileController?.reloadPage(userId: userId)
            friendsController?.reloadPage(userId: userId)
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
    


    // MARK: - Navigation

//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        super.tabBar(tabBar, didSelect: item)
//        let profVC = viewControllers?[0] as? ProfileViewController
//    }

    

    
}
