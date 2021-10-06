//
//  InfoCell.swift
//  SocialNetwork
//
//  Created by Евгений on 6.10.21.
//

import UIKit

class InfoCell: UITableViewCell {
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoImgView: UIImageView!
    @IBOutlet weak var infoNameLabel: UILabel!
    @IBOutlet weak var infoNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
