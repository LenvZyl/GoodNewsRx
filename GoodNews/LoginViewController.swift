//
//  LoginViewController.swift
//  GoodNews
//
//  Created by Len van Zyl on 2021/07/10.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "GoodNews"
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 5
        userNameTextField.placeholder = "User name"
        passwordTextField.placeholder = "Password"
        
    }

    @IBAction func loginAction(_ sender: Any) {
        self.performSegue(withIdentifier: "showMain", sender: nil)
    }
    
}
