//
//  ActivityViewController.swift
//  Your Meals
//
//  Created by Bridget Carroll on 23/03/2018.
//  Copyright © 2018 Josh Cotterell. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView: UITableView = {
        let tableView = UITableView()
        // TableView
        tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = .white
        // Dynamic cell height
        return tableView
    }()
    
    let activities = ["Steve liked your recipe.", "Steve commented on your recipe."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGrey
        
        navigationItem.title = "Activity"
        
        // Acitivity TableView
        view.addSubview(tableView)
        tableView.anchor(view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: 0, height: 0)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ActivityTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        }
        cell.activity = activities[indexPath.row]
        
        return cell
    }
    
}
