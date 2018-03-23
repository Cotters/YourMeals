//
//  AddMealVC.swift
//  Your Meals
//
//  Created by Josh Cotterell on 30/06/2017.
//  Copyright © 2017 Josh Cotterell. All rights reserved.
//

import UIKit

class AddMealVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let textFieldSize: CGFloat = 24
    
    let mealImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(r: 224, g: 224, b: 224)
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        iv.clipsToBounds = true
        return iv
    }()
    
    var cameraImgView: UIImageView!
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Meal title..."
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .yes
        tf.autocapitalizationType = .words
        tf.clearButtonMode = .always
        tf.spellCheckingType = .yes
        tf.returnKeyType = .next
        tf.layer.cornerRadius = 5
        return tf
    }()
    
    let tableViewSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Ingredients", "Method"])
        segmentedControl.selectedSegmentIndex = 0 // Select Ingredients by default
        segmentedControl.tintColor = UIColor(r: 234, g: 140, b: 0) // Orange to stick with theme
        return segmentedControl
    }()
    
    var tableView: UITableView!
    
    var method: [String] = ["Place bread in toaster and toast until it pops.", "Later a thin layer over the toast until all of one side is covered.", "Apply any other condement you wish and enjoy!"]
    var ingredients: [String] = ["Bread", "Butter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        
        // Allow user to tap screen to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // Moves the view up and down in response to keyboard showing/hiding
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearView))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeal))
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = "Add your Meal"
        
        view.addSubview(mealImageView)
        view.addSubview(titleTextField)
        
        // Top constraint = 44 means the ImageView won't be cut off by the NavBar
        // TODO: Use safeAreaLayoutGuide instead - requires xcode update i think
        mealImageView.anchor(view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topConstant: 44, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: 0, height: 200)
        
        mealImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addImage)))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        cameraImgView = UIImageView(image: #imageLiteral(resourceName: "camera"))
        mealImageView.addSubview(cameraImgView)
        cameraImgView.anchor(nil, bottom: nil, left: nil, right: nil, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: 50, height: 50)
        cameraImgView.centerXAnchor.constraint(equalTo: mealImageView.centerXAnchor).isActive = true
        cameraImgView.centerYAnchor.constraint(equalTo: mealImageView.centerYAnchor).isActive = true
        
        // Meal title textView
        titleTextField.anchor(mealImageView.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topConstant: 16, bottomConstant: 0, leftConstant: 16, rightConstant: -16, width: 0, height: textFieldSize)
        
        // Ingredients/Method table view with segmented control
        view.addSubview(tableViewSegmentedControl)
        tableViewSegmentedControl.anchor(titleTextField.bottomAnchor, bottom: nil, left: titleTextField.leftAnchor, right: titleTextField.rightAnchor, topConstant: 16, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: 0, height: 24)
        tableViewSegmentedControl.addTarget(self, action: #selector(switchTableViewContents), for: .valueChanged)
        
        // TableView
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.anchor(tableViewSegmentedControl.bottomAnchor, bottom: view.bottomAnchor, left: titleTextField.leftAnchor, right: titleTextField.rightAnchor, topConstant: 5, bottomConstant: -16, leftConstant: 0, rightConstant: 0, width: 0, height: 0)
        tableView.backgroundColor = .white
        
    }
    
    @objc func clearView() {
        self.cameraImgView.alpha = 1
        self.mealImageView.image = nil
    }
    
    @objc func addMeal() {
        print("adding meal..")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// This method adjusts the height of the view as the keyboard is shown.
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    /// This method adjusts the height of the view as the keyboard is hidden.
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @objc func addImage() {
        let alertController = UIAlertController(title: "", message: "Are you taking a photo or choosing one?", preferredStyle: .actionSheet)
        
        let imgAction = UIAlertAction(title: "Choose photo", style: .default) {
            UIAlertAction in
            
            let imgPickerController = UIImagePickerController()
            imgPickerController.delegate = self
            imgPickerController.allowsEditing = true
            
            self.present(imgPickerController, animated: true, completion: nil)
        }
        alertController.addAction(imgAction)
        
        let cameraAction = UIAlertAction(title: "Take photo", style: .default) {
            UIAlertAction in
            
            print("take me to take photo!")
        }
        alertController.addAction(cameraAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        self.cameraImgView.alpha = 1
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = originalImage
        }
        
        if let image = selectedImage {
            self.mealImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        self.cameraImgView.alpha = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    
    @objc func switchTableViewContents() {
        // TODO: Refresh tableview
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSegmentedControl.selectedSegmentIndex == 0 ? ingredients.count : method.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewSegmentedControl.selectedSegmentIndex == 0 ? 40 : 100 // TODO: Make dynamic heights
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let text = tableViewSegmentedControl.selectedSegmentIndex == 0 ? ingredients[indexPath.row] : method[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row). " + text
//        cell.detailTextLabel?.text = "\(indexPath.row). " + text
        return cell
    }
}
