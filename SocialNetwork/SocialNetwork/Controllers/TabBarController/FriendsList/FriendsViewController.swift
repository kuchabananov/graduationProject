//
//  FriendsViewController.swift
//  SocialNetwork
//
//  Created by Евгений on 9.10.21.
//

import UIKit

class FriendsViewController: UITableViewController {
   
    var friends: [Friend] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }

    func reloadPage(userId: String) {
        getFriends(userId: userId)
    }
    
    private func getFriends(userId: String) {
        NetworkManager.shared.getFriends(userId: userId) { [weak self] result in
            switch result {
            case .success(let friends):
                self?.friends = friends
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure:
                print("FAILED")
            }
        }
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendsListCell
        let friend = friends[indexPath.row]
        cell.friendNameLabel.text = "\(friend.firstName) \(friend.lastName)"
        cell.friendInfoLabel.text = friend.city?.title
        if let urlStr = friend.photo {
            let url = URL(string: urlStr)!
            DispatchQueue.global(qos: .userInitiated).async {
                UIImage.loadImageFromUrl(url: url) { image in
                    DispatchQueue.main.async {
                        cell.friendPhoto.image = image
                        cell.friendPhoto.layer.cornerRadius = 20
                        cell.layoutIfNeeded()
                    }
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userIdInt = friends[indexPath.row].id else { return }
        (tabBarController as? TabBarController)?.userId = String(userIdInt)
        tabBarController?.selectedIndex = 0
    }

}
