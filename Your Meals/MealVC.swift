//
//  MealVC.swift
//  Your Meals
//
//  Created by Josh Cotterell on 29/06/2017.
//  Copyright © 2017 Josh Cotterell. All rights reserved.
//

import UIKit


class MealVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    let methodCellId = "MethodCell"
    let ingredientCellId = "IngredientCell"
    let headerId = "Header"
    
    var meal: Meal? {
        didSet {
            guard let title = meal?.title else { return }
            navigationItem.title = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For swipe to go back feature
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        collectionView?.register(IngredientCell.self, forCellWithReuseIdentifier: ingredientCellId)
        collectionView?.register(MethodCell.self, forCellWithReuseIdentifier: methodCellId)
        collectionView?.register(MealHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        setupView()
        setupNavBar()
    }
    
    func setupView() {
        collectionView?.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .red
        
        let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "back_icon"), style: .plain, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem = backBtn
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeal))
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500) // this will need to be dynamically set
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MealHeaderCell
        header.mealImage = meal?.image
        header.mealVC = self
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ingredientCellId, for: indexPath) as! IngredientCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: methodCellId, for: indexPath) as! MethodCell
            return cell
        }
    }
    
    var mealImageView: UIImageView?
    let zoomImageView = UIImageView()
    
    let blackBackVew = UIView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()
    
    func animateImageView(mealImageView: UIImageView) {
        self.mealImageView = mealImageView // copy imageview for the zoom out func below
        
        if let startFrame = mealImageView.superview?.convert(mealImageView.frame, to: nil) {
            
            mealImageView.alpha = 0 // 'remove' the image view
            
            // Add the black overlay to hide the view
            blackBackVew.frame = self.view.frame
            blackBackVew.alpha = 0
            blackBackVew.backgroundColor = .black
            view.addSubview(blackBackVew)
            
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
    }
    
    @objc func zoomOut() {
        // Animate things back to original places and remove after completion
        if let startFrame = mealImageView!.superview?.convert(mealImageView!.frame, to: nil) {
            UIView.animate(withDuration: 0.75, animations: {
                self.zoomImageView.frame = startFrame
                self.blackBackVew.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
            }, completion: { (didComplete) in
                self.mealImageView?.alpha = 1
                self.zoomImageView.removeFromSuperview()
                self.blackBackVew.removeFromSuperview()
            })
        }
    }

    @objc func dismissView() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addMeal() {
        print("Adding meal")
    }
    
}

class IngredientCell: BaseCell {
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.text = "Ingredients"
        return lbl
    }()
    
    override func setupView() {
        addSubview(titleLbl)
        titleLbl.anchor(topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topConstant: 10, bottomConstant: 0, leftConstant: 20, rightConstant: 0, width: 0, height: 28)
    }
    
}

class MethodCell: BaseCell {
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.text = "Method"
        return lbl
    }()
    
    override func setupView() {
        addSubview(titleLbl)
        titleLbl.anchor(topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topConstant: 10, bottomConstant: 0, leftConstant: 20, rightConstant: 0, width: 0, height: 28)
    }
    
}
