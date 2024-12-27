//
//  LoginViewController.swift
//  LoginImages
//
//  Created by Ariadna Cecilia López Colín on 26/12/24.
//

import UIKit

class LoginViewController: UIViewController {

    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
    var viewModel = LoginViewModel()
    typealias ConstantSize = LoginContants.sizes
    typealias ConstantString = LoginContants.strings

    override func viewDidLoad() {
        self.view.backgroundColor = .white
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        emailTextField = UITextField()
        emailTextField.placeholder = ConstantString.emailTextFieldPlaceholder
        emailTextField.borderStyle = .roundedRect
        view.addSubview(emailTextField)
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = ConstantString.passwordTextFieldPlaceholder
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        loginButton = UIButton(type: .system)
        loginButton.setTitle(ConstantString.loginButtonTitle, for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ConstantSize.emailTextFieldTop),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: ConstantSize.emailTextFieldWidth),
            emailTextField.heightAnchor.constraint(equalToConstant: ConstantSize.emailTextFieldHeight),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: ConstantSize.passwordTextFieldTop),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: ConstantSize.passwordTextFieldWidth),
            passwordTextField.heightAnchor.constraint(equalToConstant: ConstantSize.passwordTextFieldHeight),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: ConstantSize.loginButtonTop),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func loginTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Empty email or password")
            return
        }
        viewModel.login(email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    let dogImageVC = ImageViewController()
                    let navigationController = UINavigationController(rootViewController: dogImageVC)
                    self.present(navigationController, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: ConstantString.alertTitle, message: ConstantString.alertTitleMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ConstantString.alertAction, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
