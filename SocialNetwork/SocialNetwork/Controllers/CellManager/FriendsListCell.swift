//
//  FriendsListCell.swift
//  SocialNetwork
//
//  Created by Евгений on 6.10.21.
//

import UIKit

class FriendsListCell: UITableViewCell {

    @IBOutlet weak var friendView: UIView!
    @IBOutlet weak var friendPhoto: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //friendPhoto.layer.cornerRadius = 20
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
