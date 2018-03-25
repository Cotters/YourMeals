//
//  MealFeedVC.swift
//  Your Meals
//
//  Created by Josh Cotterell on 28/06/2017.
//  Copyright © 2017 Josh Cotterell. All rights reserved.
//

import UIKit

class MealFeedVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "Cell"
    
    // TODO: - Retrieve from Firebase
    var meals:[Meal] = {
        var pizza = Meal()
        pizza.title = "Tomato and Olive Pizza"
        pizza.image = #imageLiteral(resourceName: "pizza_meal")
        pizza.cookTime = 1
        pizza.calorieCount = 442
        pizza.serveCount = 1
        
        var burger = Meal()
        burger.title = "Tasty Burgers"
        burger.image = #imageLiteral(resourceName: "burger_meal")
        burger.cookTime = 1
        burger.calorieCount = 629
        burger.serveCount = 4
        
        var salmon = Meal()
        salmon.title = "Salmon and Potato Salad"
        salmon.image = #imageLiteral(resourceName: "salmon_meal")
        salmon.cookTime = 1
        salmon.calorieCount = 231
        salmon.serveCount = 2
        
        var paella = Meal()
        paella.title = "Perfect Paella"
        paella.image = #imageLiteral(resourceName: "paella_meal")
        paella.cookTime = 2
        paella.calorieCount = 311
        paella.serveCount = 4
        
        return [pizza, burger, salmon, paella]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(MealCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Feed Me"
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MealCell
        cell.meal = meals[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextViewController = MealVC()
        nextViewController.meal = meals[indexPath.row]
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
}


class MealCell: BaseCollectionViewCell {
    
    var meal: Meal? {
        didSet {
            guard let title = meal?.title else { return }
            guard let image = meal?.image else { return }
            guard let calorieCount = meal?.calorieCount else { return }
            guard let cookTime = meal?.cookTime else { return }
            guard let serveCount = meal?.serveCount else { return }
            
            mealTitleLabel.text = title
            mealImageView.image = image
            subtitleText.text = "\(cookTime) Hours - \(calorieCount) cals - serves \(serveCount)"
            
        }
    }
    
    let mealImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let mealTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    let subtitleText: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .lightGrey
        return lbl
    }()
    
    let heartBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "heart_outline"), for: .normal)
        return btn
    }()
    
    
    override func setupView() {
        backgroundColor = .white

        addSubview(mealImageView)
        addSubview(mealTitleLabel)
        addSubview(subtitleText)
        addSubview(heartBtn)
        
        mealImageView.anchor(topAnchor, bottom: mealTitleLabel.topAnchor, left: leftAnchor, right: rightAnchor, topConstant: 0, bottomConstant: -10, leftConstant: 0, rightConstant: 0, width: 0, height: 0)
        
        mealTitleLabel.anchor(mealImageView.bottomAnchor, bottom: subtitleText.topAnchor, left: leftAnchor, right: nil, topConstant: 10, bottomConstant: 0, leftConstant: 16, rightConstant: 0, width: 0, height: 22)
        
        subtitleText.anchor(mealTitleLabel.bottomAnchor, bottom: bottomAnchor, left: mealTitleLabel.leftAnchor, right: nil, topConstant: 0, bottomConstant: -10, leftConstant: 0, rightConstant: 0, width: 0, height: 22)
        
        heartBtn.anchor(mealTitleLabel.topAnchor, bottom: nil, left: nil, right: rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: -16, width: 44, height: 44)
        heartBtn.addTarget(self, action: #selector(toggleLiked), for: .touchUpInside)
    }
    
    var liked = false
    @objc func toggleLiked() {
        liked ? heartBtn.setImage(#imageLiteral(resourceName: "heart_outline"), for: .normal) : heartBtn.setImage(#imageLiteral(resourceName: "heart_filled"), for: .normal)
        liked = (liked ? false : true) // invert the boolean value of liked
    }
    
}
