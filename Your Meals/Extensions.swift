//
//  Extensions.swift
//  Your Meals
//
//  Created by Josh Cotterell on 29/06/2017.
//  Copyright © 2017 Josh Cotterell. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let orangeTheme = UIColor(r: 230, g: 126, b: 34)
    static let lightGrey = UIColor(r: 224, g: 224, b: 224)
    static let darkGrey = UIColor(r: 25, g: 25, b: 25)
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
}

extension UIView {
    
    public func centerInView(view: UIView) {
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    
    }
    
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat, bottomConstant: CGFloat, leftConstant: CGFloat, rightConstant: CGFloat, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: rightConstant))
        }
        
        if width > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        
        if height > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        
        anchors.forEach({$0.isActive = true})
        
        
        _ = anchors
    }
    
}

extension NSAttributedString {
    static func strikeThroughText(_ text: String ) -> NSAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.white, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

extension UIViewController {
    
    func showLoginScreen() {
        present(LoginViewController(), animated: true, completion: nil)
    }
    
}
