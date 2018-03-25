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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGrey
        
        navigationItem.title = "Activity"
        
        view.addSubview(tableView)
        let guide = view.layoutMarginsGuide
        tableView.anchor(view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: 0, height: 0)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ActivityTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        }
        
        
        return cell
    }
    
    
    
}

class ActivityTableViewCell: BaseTableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "steve_prof_img")
        return imageView
    }()
    
    override func setupView() {
        contentView.addSubview(profileImageView)
        
        let guide = contentView.safeAreaLayoutGuide
        profileImageView.anchor(nil, bottom: nil, left: guide.leftAnchor, right: nil, topConstant: 5, bottomConstant: -5, leftConstant: 5, rightConstant: 5, width: 50, height: 50)
        profileImageView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    }
    
}
