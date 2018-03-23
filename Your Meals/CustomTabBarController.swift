//
//  CustomTabBarController.swift
//  Your Meals
//
//  Created by Josh Cotterell on 29/06/2017.
//  Copyright © 2017 Josh Cotterell. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let feedController = MealFeedVC(collectionViewLayout: UICollectionViewFlowLayout())
        let feedNavController = UINavigationController(rootViewController: MealFeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        feedNavController.tabBarItem.title = "Feed"
        feedNavController.tabBarItem.image = #imageLiteral(resourceName: "bell_icon")

        
        let addMealNavController = UINavigationController(rootViewController: AddMealVC())
        addMealNavController.tabBarItem.title = "Add"
        addMealNavController.tabBarItem.image = #imageLiteral(resourceName: "add_icon")
        
        
        let activityView = UINavigationController(rootViewController: ActivityViewController())
        activityView.tabBarItem.title = "Activity"
        activityView.tabBarItem.image = #imageLiteral(resourceName: "like_icon")
        
        
        let profileController = ProfileVC()
        let profileNavController = UINavigationController(rootViewController: profileController)
        profileNavController.tabBarItem.title = "Profile"
        profileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_icon")
        
        viewControllers = [feedNavController, addMealNavController, profileNavController]
        
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor(r: 229, g: 231, b: 235).cgColor
        
        tabBar.clipsToBounds = true
        tabBar.layer.addSublayer(topBorder)
        tabBar.tintColor = UIColor(r: 230, g: 126, b: 34)
        
    }
    
}
