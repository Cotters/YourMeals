//
//  AddMealVC.swift
//  Your Meals
//
//  Created by Josh Cotterell on 30/06/2017.
//  Copyright © 2017 Josh Cotterell. All rights reserved.
//

import UIKit

class AddMealVC: SegmentedTableView, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
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
        tf.returnKeyType = .done
        tf.layer.cornerRadius = 5
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        setupTableView(topAnchor: titleTextField.bottomAnchor, nil, titleTextField.leftAnchor, titleTextField.rightAnchor)
        
        // Allow user to tap screen to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
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
        print("Done")
        dismissKeyboard()
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("sel")
        
        if tableViewSegmentedControl.selectedSegmentIndex == 1 {
            if let methodCell = tableView.dequeueReusableCell(withIdentifier: "MethodCell", for: indexPath) as? MethodTableViewCell {
                // Strikethrough text
                let txt = methodCell.methodTxtView.text!
                let strike = NSAttributedString.strikeThroughText(txt)
                methodCell.methodTxtView.text = String(describing: strike)
            }
        }
        
        // Else load ingredient cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let txt = cell.textLabel!.text!
        let strike = NSAttributedString.strikeThroughText(txt)
        cell.textLabel!.text = String(describing: strike)
    }
}



























