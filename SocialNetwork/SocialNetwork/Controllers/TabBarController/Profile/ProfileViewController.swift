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
    var profilePhotos: [Photo] = []
    let collectionViewEdgeInsets = UIEdgeInsets(top: 10, left: 2, bottom: 10, right: 2)
    let collectionViewItemsInRow: CGFloat = 3
    var isFirstLaunch = true
    
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
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
    }
    
    private func setupUI() {
        userPhoto.layer.cornerRadius = userPhoto.frame.size.width / 2
    }
    
    private func requestDataFromServer(userId: String) {
        startAnimation()
        getUser(userId: userId)
    }
    
    
    private func startAnimation() {
        self.view.isUserInteractionEnabled = false
        animationView = AnimationView(frame: self.view.frame)
        self.view.addSubview(animationView!)
    }
    
    private func endAnimation() {
        self.view.isUserInteractionEnabled = true
        animationView?.removeFromSuperview()
        animationView = nil
    }
    
    private func resetData() {
        profilePhotos = []
        galleryCollectionView.reloadData()
        userPhoto.image = UIImage(systemName: "person.fill")
        userPhoto.tintColor = .systemGray3
        nameLabel.text = ""
    }
    
    public func reloadPage(userId: String) {
        isFirstLaunch ? isFirstLaunch.toggle() : resetData()
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
                statusBtn.tintColor = .black
                statusBtn.setTitle(status, for: .normal)
            } else {
                statusBtn.tintColor = .link
                statusBtn.setTitle("Set status", for: .normal)
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
        if let online = user.online {
            if online == 0 {
                onlineLabel.isHidden = true
            }
        }
    }
    
    private func getAvatar() {
        guard let urlStr = user?.photo else { return }
        let url = URL(string: urlStr)!
        DispatchQueue.global(qos: .userInitiated).async {
            UIImage.loadImageFromUrl(url: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.userPhoto.image = image
                    self?.reloadUI()
                    self?.endAnimation()
                }
            }
        }
    }
    
    private func getUser(userId: String) {
        NetworkManager.shared.getUsers(userId: userId) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                self?.getAvatar()
                self?.getPhotos(userId: userId)
                DispatchQueue.main.async {

                }
            case .failure:
                print("FAILED")
            }
        }
    }
    
    private func getPhotos(userId: String) {
        NetworkManager.shared.getPhotos(userId: userId) { [weak self] result in
            switch result {
            case .success(let photos):
                self?.profilePhotos = photos
                DispatchQueue.main.async {
                    self?.galleryCollectionView.reloadData()
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

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        profilePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = profilePhotos[indexPath.row]
        let sizeM = photo.sizes.filter( { return $0.type == "x" } ).first
        if let urlStr = sizeM?.url {
            let url = URL(string: urlStr)!
            DispatchQueue.global(qos: .userInitiated).async {
                UIImage.loadImageFromUrl(url: url) { image in
                    DispatchQueue.main.async {
                        cell.userPhoto.image = image
                        cell.userPhoto.contentMode = .scaleAspectFill
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidht: CGFloat = collectionViewEdgeInsets.left * (collectionViewItemsInRow + 1)
        let availableSpace = galleryCollectionView.frame.width - paddingWidht
        let itemSize: CGFloat = availableSpace / collectionViewItemsInRow - 1
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return collectionViewEdgeInsets

        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section:Int) -> CGFloat {
            return 1
        }
    
}
