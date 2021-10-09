//
//  ProfileViewController.swift
//  SocialNetwork
//
//  Created by Евгений on 4.10.21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var animationView: AnimationView?
    var user: User?
    
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var addInfoButton: UIButton!
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        userPhoto.layer.cornerRadius = userPhoto.frame.size.width / 2
    }
    
    private func requestDataFromServer(userId: String) {
        startAnimation()
        getUser(userId: userId)
    }
    
    
    private func startAnimation() {
        animationView = AnimationView(frame: self.view.frame)
        self.view.addSubview(animationView!)
    }
    
    private func endAnimation() {
        animationView?.removeFromSuperview()
        animationView = nil
    }
    
    public func reloadPage(userId: String) {
        requestDataFromServer(userId: userId)
    }
    
    private func reloadUI() {
        guard let user = self.user else { return }
        let firstName = user.firstName
        let lastName = user.lastName
        nameLabel.text = "\(firstName) \(lastName)"
        if let screenName = user.screenName {
            screenNameLabel.text = screenName
        }
        if let status = user.status {
            if !status.isEmpty {
                
            }
        }
        if let city = user.city?.title {
            cityLabel.text = city
        }
        if let education = user.universityName {
            educationLabel.text = education
        }
        if let followers = user.counters?.followers {
            followersLabel.text = "\(followers) followers"
        }
    
    }
    

    
    private func getUser(userId: String) {
        //guard let userId = userId else { return }
        NetworkManager.shared.getUsers(userId: userId) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                DispatchQueue.main.async {
                    self?.reloadUI()
                    self?.endAnimation()
                }
            case .failure:
                print("FAILED")
            }
        }
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAdd" {
            let vc = segue.destination as? AddInfoViewController
            vc?.user = user
        }
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
}
