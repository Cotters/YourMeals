//
//  ProfileVC.swift
//  Your Meals
//
//  Created by Josh Cotterell on 29/06/2017.
//  Copyright © 2017 Josh Cotterell. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileVC: UserContainedViewController {
    
    let profileImageSize: CGFloat = 100.0
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 50//profileImageSize/2
        iv.layer.masksToBounds = true
        iv.image = #imageLiteral(resourceName: "steve_prof_img")
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 2.0
        return iv
    }()
    
    let logoutBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Logout", for: .normal)
        btn.addTarget(self, action: #selector(logout), for: .touchUpInside)
        btn.backgroundColor = UIColor(r: 255, g: 81, b: 72)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .lightGrey
        navigationItem.title = "Profile"
        
        // Profile image
        view.addSubview(profileImageView)
        profileImageView.anchor(view.topAnchor, bottom: nil, left: nil, right: nil, topConstant: 100, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: profileImageSize, height: profileImageSize)
        view.addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        
        // Logout button
        view.addSubview(logoutBtn)
        logoutBtn.anchor(nil, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topConstant: 0, bottomConstant: -2, leftConstant: 2, rightConstant: -2, width: 0, height: 40)
    }
    
    /// Allows the user to sign out
    @objc func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
}
