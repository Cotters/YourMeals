//
//  MealVC.swift
//  Your Meals
//
//  Created by Josh Cotterell on 29/06/2017.
//  Copyright © 2017 Josh Cotterell. All rights reserved.
//

import UIKit


class MealVC: SegmentedTableView, UIGestureRecognizerDelegate {
    
    let mealImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var meal: Meal? {
        didSet {
            guard let title = meal?.title,
            let image = meal?.image else { return }
            mealImageView.image = image
            navigationItem.title = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For swipe to go back feature
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        setupView()
        setupNavBar()
        setupTableView(topAnchor: mealImageView.bottomAnchor, nil, view.leftAnchor, view.rightAnchor)
    }
    
    func setupView() {
        view.addSubview(mealImageView)
        mealImageView.anchor(view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: 0, height: 150)
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .orangeTheme
    }
    
    
    let zoomImageView = UIImageView()
    
    let blackBackVew = UIView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()

    @objc func dismissView() {
        navigationController?.popViewController(animated: true)
    }
    
}

/// Adds zooming feature when the user taps on the screen
extension MealVC {
    
    func animateImageView(mealImageView: UIImageView) {
        guard let startFrame = mealImageView.superview?.convert(mealImageView.frame, to: nil) else { return }
        
        mealImageView.alpha = 0 // 'remove' the image view
        
        // Add the black overlay to hide the view
        blackBackVew.frame = view.bounds
        blackBackVew.alpha = 0
        blackBackVew.backgroundColor = .black
        view.addSubview(blackBackVew)
        
        // Covers NavBar and StatusBar
        navBarCoverView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 20 + 44)
        navBarCoverView.backgroundColor = .black
        navBarCoverView.alpha = 0
        
        tabBarCoverView.backgroundColor = .black
        tabBarCoverView.alpha = 0
        
        if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.addSubview(navBarCoverView)
            
            tabBarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: view.frame.width, height: 49)
            keyWindow.addSubview(tabBarCoverView)
        }
        
        // Use a new image view to give the impression of the image moving
        zoomImageView.frame = startFrame
        zoomImageView.image = mealImageView.image
        zoomImageView.isUserInteractionEnabled = true
        zoomImageView.contentMode = .scaleAspectFill
        zoomImageView.clipsToBounds = true
        view.addSubview(zoomImageView)
        
        zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
        
        let height = (view.frame.width/startFrame.width) * startFrame.height
        let y = view.frame.height/2 - (height/2)
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
            self.blackBackVew.alpha = 1
            self.navBarCoverView.alpha = 1
            self.tabBarCoverView.alpha = 1
        })
    }
    
    @objc func zoomOut() {
        // Animate things back to original places and remove after completion
        if let startFrame = mealImageView.superview?.convert(mealImageView.frame, to: nil) {
            UIView.animate(withDuration: 0.75, animations: {
                self.zoomImageView.frame = startFrame
                self.blackBackVew.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
                }, completion: { (didComplete) in
                    self.mealImageView.alpha = 1
                    self.zoomImageView.removeFromSuperview()
                    self.blackBackVew.removeFromSuperview()
            })
        }
    }
}
