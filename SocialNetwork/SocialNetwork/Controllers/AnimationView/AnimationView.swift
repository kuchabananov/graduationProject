//
//  AnimationView.swift
//  SocialNetwork
//
//  Created by Евгений on 5.10.21.
//

import UIKit

class AnimationView: UIView {
    
    let contentXibName = "AnimationView"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var animationImage: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        animationImage.image = UIImage.gif(name: "downloadgif")
    }
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("AnimationView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        //addSubview(viewFromXib)
        contentView.fixInView(self)
    }
    
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
