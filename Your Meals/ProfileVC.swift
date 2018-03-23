//
//  ProfileVC.swift
//  Your Meals
//
//  Created by Josh Cotterell on 29/06/2017.
//  Copyright © 2017 Josh Cotterell. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    let profileImageSize: CGFloat = 100.0
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 50//profileImageSize/2
        iv.layer.masksToBounds = true
        iv.image = #imageLiteral(resourceName: "steve_prof_img")
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 1.0
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Profile"
        
        
        view.addSubview(profileImageView)
        profileImageView.anchor(view.topAnchor, bottom: nil, left: nil, right: nil, topConstant: 100, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: profileImageSize, height: profileImageSize)
        
        view.addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        
        
    }
    
    
    
}
