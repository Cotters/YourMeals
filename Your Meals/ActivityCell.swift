//
//  ActivityCell.swift
//  Your Meals
//
//  Created by Bridget Carroll on 25/03/2018.
//  Copyright © 2018 Josh Cotterell. All rights reserved.
//

import UIKit

class ActivityTableViewCell: BaseTableViewCell {
    
    var activity: String? {
        didSet {
            activityLbl.text = activity
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "steve_prof_img")
        return imageView
    }()
    
    let activityLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    override func setupView() {
        contentView.addSubview(profileImageView)
        
        let guide = contentView.safeAreaLayoutGuide
        profileImageView.anchor(nil, bottom: nil, left: guide.leftAnchor, right: nil, topConstant: 5, bottomConstant: -5, leftConstant: 5, rightConstant: -5, width: 50, height: 50)
        profileImageView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
        
        contentView.addSubview(activityLbl)
        activityLbl.anchor(guide.topAnchor, bottom: guide.bottomAnchor, left: profileImageView.rightAnchor, right: rightAnchor, topConstant: 5, bottomConstant: -5, leftConstant: 10, rightConstant: -5, width: 0, height: 0)
        
    }
    
}

