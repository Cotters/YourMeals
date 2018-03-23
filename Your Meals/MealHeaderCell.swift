//
//  MealHeaderCell.swift
//  Your Meals
//
//  Created by Josh Cotterell on 29/06/2017.
//  Copyright © 2017 Josh Cotterell. All rights reserved.
//

import UIKit

class MealHeaderCell: BaseCell {
    
    var mealVC: MealVC?
    
    var mealImage: UIImage? {
        didSet {
            mealImageView.image = mealImage
        }
    }
    
    let mealImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    @objc func animate() {
        mealVC?.animateImageView(mealImageView: mealImageView)
    }
    
    override func setupView() {
        addSubview(mealImageView)
        mealImageView.anchor(topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: 0, height: 0)
        
        mealImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        
    }
    
}
