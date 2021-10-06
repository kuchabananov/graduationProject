//
//  TabBarController.swift
//  SocialNetwork
//
//  Created by Евгений on 5.10.21.
//

import UIKit

class TabBarController: UITabBarController {
    
    var userId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        sendUserId()
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        super.tabBar(tabBar, didSelect: item)
//        let firstVc = viewControllers?[0] as? ProfileViewController
//        firstVc?.userId = userId
//    }
    
    private func sendUserId() {
        let myTab = self.viewControllers![0] as? ProfileViewController
        myTab!.userId = userId
    }
    
}
