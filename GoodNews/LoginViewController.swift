//
//  LoginViewController.swift
//  GoodNews
//
//  Created by Len van Zyl on 2021/07/10.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
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
        userNameTextField.becomeFirstResponder()
        
        userNameTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.userNameSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.passwordSubject).disposed(by: disposeBag)
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map { $0 ? 1 : 0.2}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }

    @IBAction func loginAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showMain", sender: nil)
    }
    
}
