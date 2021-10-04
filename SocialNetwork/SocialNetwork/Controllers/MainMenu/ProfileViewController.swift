//
//  ProfileViewController.swift
//  SocialNetwork
//
//  Created by Евгений on 4.10.21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var userId: String?
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        userPhoto.layer.cornerRadius = 50
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
