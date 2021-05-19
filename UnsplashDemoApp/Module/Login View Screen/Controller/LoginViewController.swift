//
//  LoginViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/16/21.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func passUserData(user: UserDetailViewModel)
}

class LoginViewController: UIViewController {

    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginContainerView: UIView!
    
    var loginViewModel = LoginViewModel()
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        loginViewModel.delegate = self
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        loginContainerView.layer.cornerRadius = 20
        loginContainerView.clipsToBounds = true
    }
    
    @IBAction private func cancelButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction private func loginButtonClicked(_ sender: UIButton) {
        guard let username = usernameTextField.text else { return }
        if !username.isEmpty {
            loginViewModel.getUserData(userName: username)
        }
    }
    @IBAction private func forgotPasswordButtonClicked(_ sender: UIButton) {
    }
    @IBAction private func signUpButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        guard let signUpViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        signUpViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func userDataFetched(user: UserDetailViewModel) {
        self.delegate?.passUserData(user: user)
        self.dismiss(animated: true, completion: nil)
    }
}
