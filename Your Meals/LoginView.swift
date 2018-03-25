//
//  LoginView.swift
//  Your Meals
//
//  Created by Bridget Carroll on 25/03/2018.
//  Copyright © 2018 Josh Cotterell. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        tf.textColor = .darkGrey
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.textColor = .darkGrey
        return tf
    }()
    
    let loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        btn.backgroundColor = UIColor(r: 0, g: 200, b: 110)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGrey
        
        // Allow user to tap screen to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        let titleLbl = UILabel()
        titleLbl.text = "Login"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 44)
        titleLbl.textColor = .white
        titleLbl.textAlignment = .center
        
        view.addSubview(titleLbl)
        titleLbl.anchor(view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topConstant: 20, bottomConstant: 0, leftConstant: 5, rightConstant: 05, width: 120, height: 60)
        
        // Put all components into a stack view
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginBtn])
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        // Add and anchor
        view.addSubview(stackView)
        stackView.anchor(nil, bottom: nil, left: nil, right: nil, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0, width: view.frame.width*0.8, height: view.frame.height*0.3)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func login() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error)
            }
            
            if user != nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error signing user in")
            }
            
        }
    }
    
    
}

class UserContainedViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user == nil {
                // If no user is found, allow them to login
                self.showLoginScreen()
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
}
