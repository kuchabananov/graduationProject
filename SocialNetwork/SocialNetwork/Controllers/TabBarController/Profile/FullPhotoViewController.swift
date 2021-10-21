//
//  FullPhotoViewController.swift
//  SocialNetwork
//
//  Created by Евгений on 19.10.21.
//

import UIKit

class FullPhotoViewController: UIViewController {
    
    var urlPhotoStr: String?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchPhoto()
    }

    private func setupUI() {
        cancelButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        view.layer.insertSublayer(UIView.setGradietnBackgroundView(view: view), at: 0)
    }
    
    private func fetchPhoto() {
        guard let urlPhotoStr = urlPhotoStr else { return }
        if let urlPhoto = URL(string: urlPhotoStr) {
            DispatchQueue.global(qos: .userInitiated).async {
                UIImage.loadImageFromUrl(url: urlPhoto) { photo in
                    DispatchQueue.main.async {
                        self.photoImageView.image = photo
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }

    }
    
    @IBAction func buttonTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
