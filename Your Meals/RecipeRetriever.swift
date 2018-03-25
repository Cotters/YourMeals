//
//  RecipeRetriever.swift
//  Your Meals
//
//  Created by Bridget Carroll on 25/03/2018.
//  Copyright © 2018 Josh Cotterell. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

/// Retrieves recipes for the user to view
struct RecipeReciever {
    
    /// Retrieves all of a user's meals
    func fetchMeals(forUser user: User) {
        
        let ref = Database.database().reference()
        
        ref.child("users/\(user.uid)/recipes").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let mealIds = snapshot.value as? NSDictionary
            
            /* - Load just some relevant information, not the actual meal. Only load the actual meal when it's selected.
             {
                 user/uid/recipes: {
                     12345 : {
                        name, prepTime, calories, servings, likes?
                     }
                 }
             }
             */
            
        })
        
    }
    
}
