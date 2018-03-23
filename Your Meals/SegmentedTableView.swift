//
//  SegmentedTableView.swift
//  Your Meals
//
//  Created by Bridget Carroll on 23/03/2018.
//  Copyright © 2018 Josh Cotterell. All rights reserved.
//

import UIKit

class SegmentedTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableViewSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Ingredients", "Method"])
        segmentedControl.selectedSegmentIndex = 0 // Select Ingredients by default
        segmentedControl.tintColor = UIColor(r: 234, g: 140, b: 0) // Orange to stick with theme
        return segmentedControl
    }()
    
    var tableView: UITableView!
    
    var method: [String] = ["Place bread in toaster and toast until it pops.", "Later a thin layer over the toast until all of one side is covered.", "Apply any other condement you wish and enjoy!", "Apply any other condement you wish and enjoy! Apply any other condement you wish and enjoy Apply any other condement you wish and enjoy Apply any other condement you wish and enjoy Apply any other condement you wish and enjoy Apply any other condement you wish and enjoy!"]
    var ingredients: [String] = ["Bread", "Butter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupTableView(topAnchor: NSLayoutYAxisAnchor, _ bottomAnchor: NSLayoutYAxisAnchor? = nil, _ leftAnchor: NSLayoutXAxisAnchor, _ rightAnchor: NSLayoutXAxisAnchor) {
        // Ingredients/Method table view with segmented control
        view.addSubview(tableViewSegmentedControl)
        tableViewSegmentedControl.anchor(topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topConstant: 16, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: 0, height: 24)
        tableViewSegmentedControl.addTarget(self, action: #selector(switchTableViewContents), for: .valueChanged)
        
        // TableView
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(MethodTableViewCell.self, forCellReuseIdentifier: "MethodCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = true
        // Dynamic cell height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        tableView.allowsSelection = true
        tableView.selectRow(at: IndexPath(row: 1, section: 2), animated: false, scrollPosition: .none)
        
        view.addSubview(tableView)
        tableView.anchor(tableViewSegmentedControl.bottomAnchor, bottom: view.bottomAnchor, left: tableViewSegmentedControl.leftAnchor, right: tableViewSegmentedControl.rightAnchor, topConstant: 5, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: 0, height: 0)
        tableView.backgroundColor = .white

    }
    
    @objc func switchTableViewContents() {
        // TODO: Refresh tableview
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSegmentedControl.selectedSegmentIndex == 0 ? ingredients.count : method.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve the appropriate text
        let text = tableViewSegmentedControl.selectedSegmentIndex == 0 ? ingredients[indexPath.row] : method[indexPath.row]
        
        // If showing the method, a custom cell is used
        if tableViewSegmentedControl.selectedSegmentIndex == 1 {
            if let methodCell = tableView.dequeueReusableCell(withIdentifier: "MethodCell", for: indexPath) as? MethodTableViewCell {
                // Format: 1. Heat oven to 200ºC etc.
                methodCell.methodTxtView.text = "\(indexPath.row+1). " + text
                return methodCell
            }
        }
        
        // Else load ingredient cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = text
        return cell
    }
    
}
