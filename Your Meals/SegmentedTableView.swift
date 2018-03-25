//
//  SegmentedTableView.swift
//  Your Meals
//
//  Created by Bridget Carroll on 23/03/2018.
//  Copyright © 2018 Josh Cotterell. All rights reserved.
//

import UIKit

class SegmentedTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Ingredients", "Method"])
        segmentedControl.selectedSegmentIndex = 0 // Select Ingredients by default
        segmentedControl.tintColor = .orangeTheme
        segmentedControl.addTarget(self, action: #selector(switchTableViewContents), for: .valueChanged)
        return segmentedControl
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(MethodTableViewCell.self, forCellReuseIdentifier: "MethodCell")
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = .white
        // Dynamic cell height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        return tableView
    }()
    
    var method: [String] = ["Place bread in toaster and toast until it pops.", "Later a thin layer over the toast until all of one side is covered.", "Apply any other condement you wish and enjoy!", "Apply any other condement you wish and enjoy! Apply any other condement you wish and enjoy Apply any other condement you wish and enjoy Apply any other condement you wish and enjoy Apply any other condement you wish and enjoy Apply any other condement you wish and enjoy!"]
    var ingredients: [String] = ["Bread", "Butter"]
    
    /// Defines the height of the tableView header cell.
    let headerViwHeight: CGFloat = 32
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initTableView() {
        tableView.frame = view.bounds
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func switchTableViewContents() {
        // TODO: Refresh tableview
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedControl.selectedSegmentIndex == 0 ? ingredients.count : method.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve the appropriate text
        let text = segmentedControl.selectedSegmentIndex == 0 ? ingredients[indexPath.row] : method[indexPath.row]
        
        // If showing the method, a custom cell is used
        if segmentedControl.selectedSegmentIndex == 1 {
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
    
    /// Add a strikethrough style to 'cross off' ingredients and method steps
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if segmentedControl.selectedSegmentIndex == 1 {
            if let methodCell = tableView.dequeueReusableCell(withIdentifier: "MethodCell", for: indexPath) as? MethodTableViewCell {
                // Strikethrough text
                if let methodTxt = methodCell.getMethodText() {
                    print(methodTxt)
                }
//
//                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: methodTxt)
//                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 0, range: NSMakeRange(0, attributeString.length))
//
//                methodCell.methodTxtView.text = String(describing: attributeString)
                methodCell.method = "Test"
            }
        }
        
        // Else load ingredient cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let txt = cell.textLabel?.text else { return }
        let strike = NSAttributedString.strikeThroughText(txt)
        cell.textLabel!.text = String(describing: strike)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Add a segmented control to switch between the ingredients and method
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: headerViwHeight))
        headerView.backgroundColor = .white
        headerView.addSubview(segmentedControl)
        segmentedControl.anchor(headerView.topAnchor, bottom: headerView.bottomAnchor, left: headerView.leftAnchor, right: headerView.rightAnchor, topConstant: 3, bottomConstant: -3, leftConstant: 1, rightConstant: -1, width: 0, height: 0)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerViwHeight
    }
    
}
