//
//  BaseCell.swift
//  Your Meals
//
//  Created by Josh Cotterell on 29/06/2017.
//  Copyright © 2017 Josh Cotterell. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
    }
    
}
