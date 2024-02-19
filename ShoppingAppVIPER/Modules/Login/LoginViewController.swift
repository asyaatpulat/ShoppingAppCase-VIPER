//
//  ViewController.swift
//
//  Created by Asya Atpulat on 24.10.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    
    var presenter: LoginViewToLoginPresenterProtocol?
    var router: LoginRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        setButton()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            presenter?.loginTapped(email: email, password: password)
        }
    }
    
    func setTextField() {
        emailTextField.setupRightImage(imageName: "envelope.fill")
        passwordTextField.setupRightImage(imageName: "lock.fill")
    }
    
    func setButton() {
        forgotPasswordButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension LoginViewController: LoginPresenterToLoginViewProtocol {
    func loginSuccess() {
        print("Login succesfull.")
        router?.toHome()
    }
    
    func loginFailure(error: Error) {
        print("Login failed. Error: \(error.localizedDescription)")
    }
}
