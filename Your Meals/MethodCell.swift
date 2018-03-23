//
//  MethodCell.swift
//  Your Meals
//
//  Created by Bridget Carroll on 23/03/2018.
//  Copyright © 2018 Josh Cotterell. All rights reserved.
//

import UIKit

class MethodTableViewCell: BaseTableViewCell {
    
    var methodTxtView: UITextView = {
        let txtView = UITextView()
        txtView.textColor = .black
        txtView.font = UIFont.preferredFont(forTextStyle: .body)
        txtView.isEditable = false
        txtView.isScrollEnabled = false
        txtView.clipsToBounds = true
        return txtView
    }()
    
    override func setupView() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(methodTxtView)
        methodTxtView.anchor(contentView.topAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, topConstant: 1, bottomConstant: -1, leftConstant: 1, rightConstant: 1, width: 0, height: 0)
    }
    
}
